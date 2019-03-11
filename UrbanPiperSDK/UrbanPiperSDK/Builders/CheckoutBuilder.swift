//
//  CheckoutBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 21/02/19.
//

import UIKit

/// A helper class that contains the related api's to place an order. The api's have to be called in the following order.
/// - validateCart(store:userWalletCredits:deliveryOption:cartItems:orderTotal:completion:failure), calling this function nils out the validateCouponResponse, paymentInitResponse variables
/// - validateCoupon(code:completion:failure:) call this funtion to apply the coupon, this call can be skipped if no coupon is applied, calling this funtion nils out the paymentInitResponse Variable
/// - initPayment(paymentOption) returns you details on the payment option selected, for payment option cash on delivery this function does not need to be called, the placeOrder function can be called directly
/// - placeOrder(address:deliveryDate:deliveryTime:timeSlot:paymentOption:instructions:phone:completion:failure:) places the order if there are not errors in the provided data
/// - verifyPayment(pid:) if the selected option is a payment gateway call this function to verify the payment transaction, for other payment options this function can be skipped

public class CheckoutBuilder: NSObject {
    
    internal var store: Store!
    internal var useWalletCredits: Bool!
    internal var deliveryOption: DeliveryOption!
    internal var cartItems: [CartItem]!
    internal var orderTotal: Decimal!
    
    internal var paymentOption: PaymentOption?
    
    internal var couponCode: String?

    
    internal var validateCartResponse: PreProcessOrderResponse? {
        didSet {
            if let paymentModesStringArray = validateCartResponse?.order.paymentModes {
                paymentModes = paymentModesStringArray.compactMap { PaymentOption(rawValue: $0) }
            } else {
                validateCouponResponse = nil
            }
        }
    }
    
    internal var validateCouponResponse: Order? {
        didSet {
            guard validateCouponResponse == nil else { return }
            couponCode = nil
            paymentInitResponse = nil
        }
    }

    internal var paymentInitResponse: PaymentInitResponse? {
        didSet {
            guard paymentInitResponse == nil else { return }
            orderResponse = nil
        }
    }

    internal var orderResponse: OrderResponse? {
        didSet {
            guard orderResponse == nil else { return }
            paymentOption = nil
        }
    }
    
    internal var paymentModes: [PaymentOption]?

    /// Returns a list of payment options supported by the business, the validateCart function has to be called atleast once to return the payment options
    public var getPaymentModes: [PaymentOption]? {
        assert(paymentModes != nil, "call validateCart function to retrive the supported payment options")
        guard let modes = paymentModes else { return nil }
        return modes
    }

    internal var order: Order? {
        return validateCouponResponse ?? validateCartResponse?.order
    }

    
    
    /// Use this function to validate the items in cart, get the supported payments options, get order details such as taxes, delivery charges, payment charges etc.
    ///
    /// - Parameters:
    ///   - store: the store at which the order is to placed
    ///   - useWalletCredits: setting this variable as true enable spilt payment where on part of the payment can be made using the users wallet amount and the rest from the payment option.
    ///   - deliveryOption: the delivery option selected by the user
    ///   - cartItems: the user added items from the cart
    ///   - orderTotal: the total value of the cart
    ///   - completion: success callback with PreProcessOrderResponse which contains order details like taxes, delivery charges, payment charges etc.
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func validateCart(store: Store,
                                                useWalletCredits: Bool,
                                                deliveryOption: DeliveryOption,
                                                cartItems: [CartItem],
                                                orderTotal: Decimal,
                                                completion: ((PreProcessOrderResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask? {
        assert(UrbanPiperSDK.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiperSDK.shared.getUser() != nil else { return nil }

        self.store = nil
        self.useWalletCredits = nil
        self.deliveryOption = nil
        self.cartItems = nil
        self.orderTotal = nil
        
        validateCartResponse = nil
        
        self.clearCoupon()

        return APIManager.shared.preProcessOrder(storeId: store.bizLocationId,
                                                 applyWalletCredit: useWalletCredits,
                                                 deliveryOption: deliveryOption,
                                                 cartItems: cartItems,
                                                 orderTotal: orderTotal,
                                                 completion:
            { [weak self] (preProcessOrderResponse) in
                self?.store = store
                self?.useWalletCredits = useWalletCredits
                self?.deliveryOption = deliveryOption
                self?.cartItems = cartItems
                self?.orderTotal = orderTotal
                
                self?.validateCartResponse = preProcessOrderResponse
                completion?(preProcessOrderResponse)
        }, failure: failure)
    }
    
    /// Apply a coupon to the cart items using this function, the coupon code can either be a code from the getCoupons api call or a code entered by the user
    ///
    /// - Parameters:
    ///   - code: the coupon code to apply
    ///   - completion: success callback with Order object which contains order details and the discount applied to the cart
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func validateCoupon(code: String,
                                                  completion: ((Order?) -> Void)?,
                                                  failure: APIFailure?) -> URLSessionDataTask? {
        assert(UrbanPiperSDK.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiperSDK.shared.getUser() != nil else { return nil }

        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
        guard validateCartResponse != nil else { return nil }
        
        return APIManager.shared.apply(coupon: code,
                                       storeId: store.bizLocationId,
                                       deliveryOption: deliveryOption,
                                       cartItems: cartItems,
                                       applyWalletCredit: useWalletCredits,
                                       completion:
            { [weak self] (validateCouponResponse) in
                self?.validateCouponResponse = validateCouponResponse
                self?.couponCode = code
                completion?(validateCouponResponse)
            }, failure: failure)
    }
    
    /// call this funtion when the clear the applied coupon
    public func clearCoupon() {
        validateCouponResponse = nil
        couponCode = nil
    }

    /// Call this function to initialize a payment in the urbanpiper server before performing a payment for all the payment options except Cash On Delivery, for COD you can skip this function and call directly the place order function
    ///
    /// - Parameters:
    ///   - paymentOption: payment option selected by the user
    ///   - completion: success callck with PaymentInitResponse containing details on the payment option selected, for payment option cash on delivery this function does not need to be called, the placeOrder function can be called directly
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    @discardableResult public func initPayment(paymentOption: PaymentOption,
                                               completion: ((PaymentInitResponse?) -> Void)?,
                                               failure: APIFailure?) -> URLSessionDataTask? {
        assert(UrbanPiperSDK.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiperSDK.shared.getUser() != nil else { return nil }

        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
        guard validateCartResponse != nil else { return nil }

        assert(paymentOption != .select, "Select an valid payment option")
        guard paymentOption != .select else { return nil }
        
        assert(paymentOption == .cash, "For cash payment option initPayment call is not needed, the placeOrder method can be called directly")
        guard paymentOption != .cash else { return nil}
        
        paymentInitResponse = nil
        
        guard let payableAmount = order?.payableAmount else { return nil }
        
        let purpose = OnlinePaymentPurpose.ordering
        return APIManager.shared.initiateOnlinePayment(paymentOption: paymentOption,
                                                       purpose: purpose,
                                                       totalAmount: payableAmount,
                                                       storeId: store.bizLocationId,
                                                       completion:
            {[weak self] (paymentInitResponse) in
                self?.paymentOption = paymentOption
                self?.paymentInitResponse = paymentInitResponse
                completion?(paymentInitResponse)
            }, failure: failure)
    }
    
    internal func deliveryDateTime(date: Date, time: Date) -> Date {
        var units: Set<Calendar.Component> = [.day, .month, .year]
        var comps: DateComponents = Calendar.current.dateComponents(units, from: date)
        let day: Date = Calendar.current.date(from: comps)!
        
        units = [.hour, .minute, .second]
        comps = Calendar.current.dateComponents(units, from: time)
        
        return Calendar.current.date(byAdding: comps, to: day)!
    }
    
    /// API call to  place the order in urbanpiper server
    ///
    /// - Parameters:
    ///   - address: Optional. an address object from the users saved addresses, can be set to nil for pick up delivery option
    ///   - deliveryDate: the date of the order delivery
    ///   - deliveryTime: the time of the order delivery
    ///   - timeSlot: Optional. the user selected timeSlot, the available timeSlots for a store is available either in the nearest store object if set on a store by store level or the biz object returned in the nearest store api call
    ///   - paymentOption: the payment option selected by the user, the payment option needs to be the same as the one passed in the initPayment call if payment option is not cash on delivery
    ///   - instructions: the instruction to be added to the order
    ///   - phone: the phone number of the user
    ///   - completion: success callback with OrderResponse containing the order id and the order status etc
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult public func placeOrder(address: Address?,
                                              deliveryDate: Date,
                                              deliveryTime: Date,
                                              timeSlot: TimeSlot?,
                                              paymentOption: PaymentOption,
                                              instructions: String,
                                              phone: String,
                                              completion: ((OrderResponse?) -> Void)?,
                                              failure: APIFailure?) -> URLSessionDataTask? {
        assert(UrbanPiperSDK.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiperSDK.shared.getUser() != nil else { return nil }

        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
        guard validateCartResponse != nil else { return nil }
        
        if let paymentInitPaymentOption = self.paymentOption, paymentInitPaymentOption != paymentOption, paymentOption != .cash {
            assert(paymentInitResponse != nil, "payment option passed differs from the payment option passed in the initPayment method, to change payment option please call init payment again with the new payment option")
            return nil
        } else if paymentOption == .cash {
            self.paymentOption = nil
            self.paymentInitResponse = nil
        } else if paymentInitResponse == nil {
            assert(paymentInitResponse != nil, "paymentInitResponse is nil, call initPayment method first")
            return nil
        }
        
        orderResponse = nil
        
        guard paymentOption == .cash || paymentInitResponse != nil else { return nil }
        return APIManager.shared.placeOrder(address: deliveryOption != .pickUp ? address : nil,
                                            cartItems: cartItems,
                                            deliveryDate: deliveryDateTime(date: deliveryDate, time: deliveryTime),
                                            timeSlot: timeSlot,
                                            deliveryOption: deliveryOption,
                                            instructions: instructions,
                                            phone: phone,
                                            storeId: store.bizLocationId,
                                            paymentOption: paymentOption,
                                            taxRate: order?.taxRate ?? store.taxRate ?? 0,
                                            couponCode: couponCode,
                                            deliveryCharge: order?.deliveryCharge ?? store.deliveryCharge ?? 0,
                                            discountApplied: validateCouponResponse?.discount?.value ?? 0,
                                            itemTaxes: order?.itemTaxes ?? store.itemTaxes ?? 0,
                                            packagingCharge: order?.packagingCharge ?? store.packagingCharge ?? 0,
                                            orderSubTotal: order?.orderSubtotal ?? orderTotal ?? 0,
                                            orderTotal: order?.payableAmount ?? orderTotal ?? 0,
                                            applyWalletCredit: useWalletCredits,
                                            walletCreditApplied: order?.walletCreditApplied ?? 0,
                                            payableAmount: order?.payableAmount ?? orderTotal ?? 0,
                                            paymentInitResponse: paymentInitResponse,
                                            completion:
            { [weak self] (orderResponse) in
                self?.paymentOption = paymentOption
                self?.orderResponse = orderResponse
                completion?(orderResponse)
        }, failure: failure)
    }
    
    /// API call the verify the payment transaction with the UrbanPiper server for payment gateway payment option
    ///
    /// - Parameters:
    ///   - pid: the payment id from the payment gateway
    ///   - completion: success callback with OrderVerifyTxnResponse
    ///   - failure: failure callback with UPError object, the UPError object contains the data from the api
    /// - Returns: Return an instance of URLSessionDataTask
    @discardableResult @objc public func verifyPayment(pid: String,
                                                       completion: @escaping ((OrderVerifyTxnResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(UrbanPiperSDK.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiperSDK.shared.getUser() != nil else { return nil }

        assert(orderResponse != nil, "orderResponse is nil, call placeOrder method first")
        guard orderResponse != nil else { return nil }

        assert(paymentOption! == .paymentGateway, "verify payment method should be called only for the paymentGateway paymentOption")
        guard paymentOption! == .paymentGateway else { return nil }

        guard let orderId = orderResponse?.orderId, let transactionId = paymentInitResponse?.transactionId else { return nil }
        return APIManager.shared.verifyPayment(pid: pid, orderId: orderId, transactionId: transactionId, completion: completion, failure: failure)
    }

}
