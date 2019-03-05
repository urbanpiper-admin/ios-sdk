//
//  CheckoutBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 21/02/19.
//

import UIKit

public class CheckoutBuilder: NSObject {
    
    internal var store: Store!
    internal var useWalletCredits: Bool!
    internal var deliveryOption: DeliveryOption!
    internal var cartItems: [CartItem]!
    internal var orderTotal: Decimal!
    
    internal var paymentOption: PaymentOption?
    
    public var couponCode: String?

    
    internal var validateCartResponse: PreProcessOrderResponse? {
        didSet {
            guard validateCartResponse == nil else { return }
            validateCouponResponse = nil
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

    public var getPaymentModes: [PaymentOption]? {
        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
        guard let paymentModesStringArray = validateCartResponse?.order.paymentModes else { return nil }
        var paymentArray: [PaymentOption] = paymentModesStringArray.compactMap { PaymentOption(rawValue: $0) }
        return paymentArray
    }

    public var order: Order? {
        return validateCouponResponse ?? validateCartResponse?.order
    }

    
    
    @discardableResult public func validateCart(store: Store,
                                                useWalletCredits: Bool,
                                                deliveryOption: DeliveryOption,
                                                cartItems: [CartItem],
                                                orderTotal: Decimal,
                                                completion: ((PreProcessOrderResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask {
        self.store = nil
        self.useWalletCredits = nil
        self.deliveryOption = nil
        self.cartItems = nil
        self.orderTotal = nil
        
        validateCartResponse = nil
        
        self.clearCoupon()

        return APIManager.shared.preProcessOrder(bizLocationId: store.bizLocationId,
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
    
    @discardableResult public func validateCoupon(code: String,
                                                  completion: ((Order?) -> Void)?,
                                                  failure: APIFailure?) -> URLSessionDataTask? {
        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
        guard validateCartResponse != nil else { return nil }
        
        validateCouponResponse = nil
        
        guard validateCartResponse != nil else { return nil }
        let currentCartItemCount: Int = self.cartItems?.reduce (0, { $0 + $1.quantity } ) ?? 0
        
        let newCartItemCount: Int = cartItems.reduce (0, { $0 + $1.quantity } )
        
        guard currentCartItemCount == newCartItemCount else { return nil }

        return APIManager.shared.apply(coupon: code,
                                       storeLocationId: store.bizLocationId,
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
    
    public func clearCoupon() {
        validateCouponResponse = nil
        couponCode = nil
    }

    @discardableResult public func initPayment(paymentOption: PaymentOption,
                                               completion: ((PaymentInitResponse?) -> Void)?,
                                               failure: APIFailure?) -> URLSessionDataTask? {
        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
        guard validateCartResponse != nil else { return nil }

        assert(paymentOption == .cash, "For cash payment option initPayment call is not needed, the placeOrder method can be called directly")
        guard paymentOption != .cash else { return nil}
        
        paymentInitResponse = nil
        
        guard let payableAmount = order?.payableAmount else { return nil }
        
        let purpose = OnlinePaymentPurpose.ordering
        return APIManager.shared.initiateOnlinePayment(paymentOption: paymentOption,
                                                       purpose: purpose,
                                                       totalAmount: payableAmount,
                                                       bizLocationId: store.bizLocationId,
                                                       completion:
            {[weak self] (paymentInitResponse) in
                self?.paymentOption = paymentOption
                self?.paymentInitResponse = paymentInitResponse
                completion?(paymentInitResponse)
            }, failure: failure)
    }
    
    public func deliveryDateTime(date: Date, time: Date) -> Date {
        var units: Set<Calendar.Component> = [.day, .month, .year]
        var comps: DateComponents = Calendar.current.dateComponents(units, from: date)
        let day: Date = Calendar.current.date(from: comps)!
        
        units = [.hour, .minute, .second]
        comps = Calendar.current.dateComponents(units, from: time)
        
        return Calendar.current.date(byAdding: comps, to: day)!
    }
    
    @discardableResult public func placeOrder(address: Address?,
                                              deliveryDate: Date,
                                              deliveryTime: Date,
                                              timeSlot: TimeSlot?,
                                              paymentOption: PaymentOption,
                                              instructions: String,
                                              phone: String,
                                              completion: ((OrderResponse?) -> Void)?,
                                              failure: APIFailure?) -> URLSessionDataTask? {
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
                                            bizLocationId: store.bizLocationId,
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
    
    @discardableResult @objc public func verifyPayment(pid: String,
                                                       completion: @escaping ((OrderVerifyTxnResponse?) -> Void), failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(orderResponse != nil, "orderResponse is nil, call placeOrder method first")
        guard orderResponse != nil else { return nil }

        assert(paymentOption! == .paymentGateway, "verify payment method should be called only for the paymentGateway paymentOption")
        guard paymentOption! == .paymentGateway else { return nil }

        guard let orderId = orderResponse?.orderId, let transactionId = paymentInitResponse?.transactionId else { return nil }
        return APIManager.shared.verifyPayment(pid: pid, orderId: orderId, transactionId: transactionId, completion: completion, failure: failure)
    }

}
