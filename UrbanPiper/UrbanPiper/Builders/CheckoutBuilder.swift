//
//  CheckoutBuilder.swift
//  UrbanPiper
//
//  Created by Vid on 21/02/19.
//

import RxSwift
import UIKit

/// A helper class that contains the related api's to place an order. The api's have to be called in the following order.
///
/// CheckoutBuilder is initialized by calling `UrbanPiper.startCheckout(...)`.
///
/// - `validateCart(...)` calling this function invalidates the previous calls to `validateCoupon(...)`, and `initPayment(...)`, the response values of both the calls should be discarded
/// - `validateCoupon(...)`, call this function to apply a coupon, this call can be skipped if no coupon is applied, calling this function invalidates the previous calls to `initPayment(...)`, the response values of the call should be discarded
/// - `initPayment(...)`, returns you details on the payment option selected, for payment option cash on delivery this api call can be skipped and the placeOrder function can be called directly
/// - `placeOrder(...)`, places the order if there are no errors in the provided data
/// - `verifyPayment(...)`, if the selected option is a payment gateway call this function to verify the payment transaction, for other payment options this function can be skipped

public class CheckoutBuilder: NSObject {
    internal var store: Store!
    internal var useWalletCredits: Bool!
    internal var deliveryOption: DeliveryOption!
    internal var cartItems: [CartItem]!
    internal var orderTotal: Double!

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

    /// Returns a list of payment options supported by the business, the `validateCart(...)`, API has to be called atleast once to return the payment options
    public func getPaymentModes() -> [PaymentOption]? {
        assert(paymentModes != nil, "call validateCart function to retrieve the supported payment options")
        guard let modes = paymentModes else { return nil }
        return modes
    }

    internal var order: Order? {
        validateCouponResponse ?? validateCartResponse?.order
    }

    /// API call to validate the items in cart, get the supported payments options, get order details such as taxes, delivery charges, payment charges etc.
    ///
    /// - Parameters:
    ///   - store: The store at which the order is to placed
    ///   - useWalletCredits: Setting this variable as true enables spilt payment where one part of the payment can be made using the user's wallet amount and the rest from the selected payment option.
    ///   - deliveryOption: The delivery option selected by the user
    ///   - cartItems: The user added items from the cart
    ///   - orderTotal: The total value of the cart
    ///   - completion: `APICompletion` with `PreProcessOrderResponse` which contains order details like taxes, delivery charges, payment charges etc.
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func validateCart(store: Store,
                                                useWalletCredits: Bool,
                                                deliveryOption: DeliveryOption,
                                                cartItems: [CartItem],
                                                orderTotal: Double,
                                                completion: APICompletion<PreProcessOrderResponse>?, failure: APIFailure?) -> URLSessionDataTask? {
        assert(cartItems.count > 0, "Provided cart items variable is empty")
        guard cartItems.count > 0 else { return nil }

        self.store = store
        self.useWalletCredits = useWalletCredits
        self.deliveryOption = deliveryOption
        self.cartItems = cartItems
        self.orderTotal = orderTotal

        validateCartResponse = nil

        clearCoupon()

        let upAPI = PaymentsAPI.preProcessOrder(storeId: store.bizLocationid, applyWalletCredit: useWalletCredits,
                                                deliveryOption: deliveryOption, cartItems: cartItems, orderTotal: orderTotal)

        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: { [weak self] preProcessOrderResponse in
            self?.validateCartResponse = preProcessOrderResponse
            completion?(preProcessOrderResponse)
            } as APICompletion<PreProcessOrderResponse>, failure: { [weak self] error in
                self?.store = nil
                self?.useWalletCredits = nil
                self?.deliveryOption = nil
                self?.cartItems = nil
                self?.orderTotal = nil
                failure?(error)
        })
    }

    public func validateCart(store: Store,
                      useWalletCredits: Bool,
                      deliveryOption: DeliveryOption,
                      cartItems: [CartItem],
                      orderTotal: Double) -> Observable<PreProcessOrderResponse>? {
        assert(cartItems.count > 0, "Provided cart items variable is empty")
        guard cartItems.count > 0 else { return nil }

        self.store = store
        self.useWalletCredits = useWalletCredits
        self.deliveryOption = deliveryOption
        self.cartItems = cartItems
        self.orderTotal = orderTotal

        validateCartResponse = nil

        clearCoupon()

        let upAPI = PaymentsAPI.preProcessOrder(storeId: store.bizLocationid, applyWalletCredit: useWalletCredits,
                                                deliveryOption: deliveryOption, cartItems: cartItems, orderTotal: orderTotal)
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] preProcessOrderResponse in
                self?.validateCartResponse = preProcessOrderResponse
                }, onError: { [weak self] _ in
                    self?.store = nil
                    self?.useWalletCredits = nil
                    self?.deliveryOption = nil
                    self?.cartItems = nil
                    self?.orderTotal = nil
            })
    }

    /// Apply a coupon to the cart items using this function, the coupon code can either be a code from the `UrbanPiper.getOffers(...)`, api call or a code entered by the user
    ///
    /// - Parameters:
    ///   - code: The coupon code to apply
    ///   - completion: `APICompletion` with `Order` object which contains order details and the discount applied to the cart
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func validateCoupon(code: String,
                                                  completion: APICompletion<Order>?,
                                                  failure: APIFailure?) -> URLSessionDataTask? {
        assert(UrbanPiper.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiper.shared.getUser() != nil else { return nil }

        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
        guard validateCartResponse != nil else { return nil }

        let upAPI = OffersAPI.applyCoupon(coupon: code, storeId: store.bizLocationid, deliveryOption: deliveryOption, cartItems: cartItems, applyWalletCredits: useWalletCredits)

        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: { [weak self] validateCouponResponse in
            self?.validateCouponResponse = validateCouponResponse
            self?.couponCode = code
            completion?(validateCouponResponse)
        } as APICompletion<Order>, failure: failure)
    }

    public func validateCoupon(code: String) -> Observable<Order>? {
        assert(UrbanPiper.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiper.shared.getUser() != nil else { return nil }

//        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
//        guard validateCartResponse != nil else { return nil }

        let upAPI = OffersAPI.applyCoupon(coupon: code, storeId: store.bizLocationid, deliveryOption: deliveryOption, cartItems: cartItems, applyWalletCredits: useWalletCredits)
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] validateCouponResponse in
                self?.validateCouponResponse = validateCouponResponse
                self?.couponCode = code
            })
    }

    /// call this function to clear the applied coupon
    public func clearCoupon() {
        validateCouponResponse = nil
        couponCode = nil
    }

    /// API call to initialize a payment in the urbanpiper server before performing a payment for all the payment options except Cash On Delivery, for COD you can skip this function and call directly the `placeOrder(...)`, API
    ///
    /// - Parameters:
    ///   - paymentOption: Payment option selected by the user
    ///   - completion: `APICompletion` with `PaymentInitResponse` containing details on the payment option selected
    ///   - failure: `APIFailure` closure with `UPError`
    @discardableResult public func initPayment(paymentOption: PaymentOption,
                                               completion: APICompletion<PaymentInitResponse>?,
                                               failure: APIFailure?) -> URLSessionDataTask? {
        assert(UrbanPiper.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiper.shared.getUser() != nil else { return nil }

        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
        guard validateCartResponse != nil else { return nil }

        assert(paymentOption != .select, "Select an valid payment option")
        guard paymentOption != .select else { return nil }

        assert(paymentOption != .cash, "For cash payment option initPayment call is not needed, the placeOrder method can be called directly")
        guard paymentOption != .cash else { return nil }

        paymentInitResponse = nil

        guard let payableAmount = order?.payableAmount else { return nil }

        let upAPI = PaymentsAPI.initiateOnlinePayment(paymentOption: paymentOption, totalAmount: payableAmount, storeId: store.bizLocationid)

        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: { [weak self] paymentInitResponse in
            self?.paymentOption = paymentOption
            self?.paymentInitResponse = paymentInitResponse
            completion?(paymentInitResponse)
        } as APICompletion<PaymentInitResponse>, failure: failure)
    }

    public func initPayment(paymentOption: PaymentOption) -> Observable<PaymentInitResponse>? {
        assert(UrbanPiper.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiper.shared.getUser() != nil else { return nil }

        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
        guard validateCartResponse != nil else { return nil }

        assert(paymentOption != .select, "Select an valid payment option")
        guard paymentOption != .select else { return nil }

        assert(paymentOption != .cash, "For cash payment option initPayment call is not needed, the placeOrder method can be called directly")
        guard paymentOption != .cash else { return nil }

        paymentInitResponse = nil

        guard let payableAmount = order?.payableAmount else { return nil }

        let upAPI = PaymentsAPI.initiateOnlinePayment(paymentOption: paymentOption, totalAmount: payableAmount, storeId: store.bizLocationid)
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] paymentInitResponse in
                self?.paymentOption = paymentOption
                self?.paymentInitResponse = paymentInitResponse
            })
    }

    internal func deliveryDateTime(date: Date, time: Date) -> Date {
        var units: Set<Calendar.Component> = [.day, .month, .year]
        var comps: DateComponents = Calendar.current.dateComponents(units, from: date)
        let day: Date = Calendar.current.date(from: comps)!

        units = [.hour, .minute, .second]
        comps = Calendar.current.dateComponents(units, from: time)

        return Calendar.current.date(byAdding: comps, to: day)!
    }

    /// API call to place the order in urbanpiper server
    ///
    /// - Parameters:
    ///   - address: Optional. An address object from the user's saved addresses, can be set to nil for `DeliveryOption.pickUp`
    ///   - deliveryDate: The date of the order delivery
    ///   - deliveryTime: The time of the order delivery
    ///   - timeSlot: Optional. The user selected timeSlot, the available timeSlots for a store is returned either in the nearest store object if set on a store by store level or the biz object returned in the nearest store api call. Should be set nil when not using timeslots.
    ///   - paymentOption: The payment option selected by the user, the payment option needs to be the same as the one passed in the initPayment call if payment option is not cash on delivery
    ///   - instructions: The instructions to be added to the order
    ///   - phone: The phone number of the user
    ///   - completion: `APICompletion` with `OrderResponse` containing the order id, order status etc
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult public func placeOrder(address: Address?,
                                              deliveryDate: Date,
                                              deliveryTime: Date,
                                              timeSlot: TimeSlot?,
                                              paymentOption: PaymentOption,
                                              instructions: String,
                                              phone: String,
                                              completion: APICompletion<OrderResponse>?,
                                              failure: APIFailure?) -> URLSessionDataTask? {
        assert(UrbanPiper.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiper.shared.getUser() != nil else { return nil }

        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
        guard validateCartResponse != nil else { return nil }

        if let paymentInitPaymentOption = self.paymentOption, paymentInitPaymentOption != paymentOption, paymentOption != .cash {
            assert(paymentInitResponse != nil, "payment option passed differs from the payment option passed in the initPayment method, to change payment option please call init payment again with the new payment option")
            return nil
        } else if paymentOption == .cash || paymentOption == .prepaid {
            self.paymentOption = nil
            paymentInitResponse = nil
        } else if paymentInitResponse == nil {
            assert(paymentInitResponse != nil, "paymentInitResponse is nil, call initPayment method first")
            return nil
        }

        orderResponse = nil

        guard paymentOption == .cash || paymentOption == .prepaid || paymentInitResponse != nil else { return nil }

        let upAPI = PaymentsAPI.placeOrder(address: deliveryOption != .pickUp ? address : nil,
                                           cartItems: cartItems,
                                           deliveryDate: deliveryDateTime(date: deliveryDate, time: deliveryTime),
                                           timeSlot: timeSlot,
                                           deliveryOption: deliveryOption,
                                           instructions: instructions,
                                           phone: phone,
                                           storeId: store.bizLocationid,
                                           paymentOption: paymentOption,
                                           taxRate: order?.taxRate ?? 0,
                                           couponCode: couponCode,
                                           deliveryCharge: order?.deliveryCharge ?? 0,
                                           discountApplied: validateCouponResponse?.discount?.value ?? 0,
                                           itemTaxes: order?.itemTaxes ?? store.itemTaxes ?? 0,
                                           packagingCharge: order?.packagingCharge ?? 0,
                                           orderSubTotal: order?.orderSubtotal ?? orderTotal ?? 0,
                                           orderTotal: order?.payableAmount ?? orderTotal ?? 0,
                                           applyWalletCredit: useWalletCredits,
                                           walletCreditApplied: order?.walletCreditApplied ?? 0,
                                           payableAmount: order?.payableAmount ?? orderTotal ?? 0,
                                           paymentInitResponse: paymentInitResponse)

        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: { [weak self] orderResponse in
            self?.paymentOption = paymentOption
            self?.orderResponse = orderResponse
            completion?(orderResponse)
        } as APICompletion<OrderResponse>, failure: failure)
    }

    public func placeOrder(address: Address?,
                    deliveryDate: Date,
                    deliveryTime: Date,
                    timeSlot: TimeSlot?,
                    paymentOption: PaymentOption,
                    instructions: String,
                    phone: String) -> Observable<OrderResponse>? {
        assert(UrbanPiper.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiper.shared.getUser() != nil else { return nil }

        assert(validateCartResponse != nil, "validateCartResponse is nil, call validateCart method first")
        guard validateCartResponse != nil else { return nil }

        if let paymentInitPaymentOption = self.paymentOption, paymentInitPaymentOption != paymentOption, paymentOption != .cash {
            assert(paymentInitResponse != nil, "payment option passed differs from the payment option passed in the initPayment method, to change payment option please call init payment again with the new payment option")
            return nil
        } else if paymentOption == .cash || paymentOption == .prepaid {
            self.paymentOption = nil
            paymentInitResponse = nil
        } else if paymentInitResponse == nil {
            assert(paymentInitResponse != nil, "paymentInitResponse is nil, call initPayment method first")
            return nil
        }

        orderResponse = nil

        guard paymentOption == .cash || paymentOption == .prepaid || paymentInitResponse != nil else { return nil }

        let upAPI = PaymentsAPI.placeOrder(address: deliveryOption != .pickUp ? address : nil,
                                           cartItems: cartItems,
                                           deliveryDate: deliveryDateTime(date: deliveryDate, time: deliveryTime),
                                           timeSlot: timeSlot,
                                           deliveryOption: deliveryOption,
                                           instructions: instructions,
                                           phone: phone,
                                           storeId: store.bizLocationid,
                                           paymentOption: paymentOption,
                                           taxRate: order?.taxRate ?? 0,
                                           couponCode: couponCode,
                                           deliveryCharge: order?.deliveryCharge ?? 0,
                                           discountApplied: validateCouponResponse?.discount?.value ?? 0,
                                           itemTaxes: order?.itemTaxes ?? store.itemTaxes ?? 0,
                                           packagingCharge: order?.packagingCharge ?? 0,
                                           orderSubTotal: order?.orderSubtotal ?? orderTotal ?? 0,
                                           orderTotal: order?.payableAmount ?? orderTotal ?? 0,
                                           applyWalletCredit: useWalletCredits,
                                           walletCreditApplied: order?.walletCreditApplied ?? 0,
                                           payableAmount: order?.payableAmount ?? orderTotal ?? 0,
                                           paymentInitResponse: paymentInitResponse)
        return APIManager.shared.apiObservable(upAPI: upAPI)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] orderResponse in
                self?.paymentOption = paymentOption
                self?.orderResponse = orderResponse
            })
    }

    /// API call the verify the payment transaction with the UrbanPiper server for `PaymentOption.paymentGateway`
    ///
    /// - Parameters:
    ///   - pid: The payment id from the payment gateway response
    ///   - completion: `APICompletion` with `OrderVerifyTxnResponse`
    ///   - failure: `APIFailure` closure with `UPError`
    /// - Returns: An instance of URLSessionDataTask
    @discardableResult @objc public func verifyPayment(pid: String,
                                                       completion: @escaping APICompletion<OrderVerifyTxnResponse>, failure: @escaping APIFailure) -> URLSessionDataTask? {
        assert(UrbanPiper.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiper.shared.getUser() != nil else { return nil }

        assert(orderResponse != nil, "orderResponse is nil, call placeOrder method first")
        guard orderResponse != nil else { return nil }

        assert(paymentOption! == .paymentGateway, "verify payment method should be called only for the paymentGateway paymentOption")
        guard paymentOption! == .paymentGateway else { return nil }

        guard let orderId = orderResponse?.orderid, let transactionId = paymentInitResponse?.transactionid else { return nil }
        let upAPI = PaymentsAPI.verifyPayment(pid: pid, orderId: String(orderId), transactionId: transactionId)
        return APIManager.shared.apiDataTask(upAPI: upAPI, completion: completion, failure: failure)
    }

    public func verifyPayment(pid: String) -> Observable<OrderVerifyTxnResponse>? {
        assert(UrbanPiper.shared.getUser() != nil, "The user has to logged in to call this function")
        guard UrbanPiper.shared.getUser() != nil else { return nil }

        assert(orderResponse != nil, "orderResponse is nil, call placeOrder method first")
        guard orderResponse != nil else { return nil }

        assert(paymentOption! == .paymentGateway, "verify payment method should be called only for the paymentGateway paymentOption")
        guard paymentOption! == .paymentGateway else { return nil }

        guard let orderId = orderResponse?.orderid, let transactionId = paymentInitResponse?.transactionid else { return nil }

        let upAPI = PaymentsAPI.verifyPayment(pid: pid, orderId: String(orderId), transactionId: transactionId)
        return APIManager.shared.apiObservable(upAPI: upAPI)
    }

    public func orderPlaced(orderId: Int) {
        AnalyticsManager.shared.track(event: .purchaseCompleted(orderID: orderId,
                                                                userWalletBalance: UserManager.shared.currentUser?.userBizInfoResponse?.userBizInfos.last?.balance ?? Double.zero,
                                                                checkoutBuilder: self,
                                                                isReorder: CartManager.shared.isReorder))
    }
}
