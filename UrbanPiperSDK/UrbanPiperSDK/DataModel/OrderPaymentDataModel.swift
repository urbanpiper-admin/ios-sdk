//
//  OrderPaymentDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

public enum PaymentGateway: String {
    case razorpay = "razorpay"
    case paytabs = "paytabs"
}

@objc public protocol OrderPaymentDataModelDelegate {
    
    func refreshPreProcessingUI(_ isRefreshing: Bool)
    func refreshWalletUI(_ isRefreshing: Bool)
    
    @objc func refreshApplyCouponUI(_ isRefreshing: Bool, code: String)
    
    func initiatingPayment(isProcessing: Bool)
    
    func placingOrder(isProcessing: Bool)
    
    func verifyingTransaction(isProcessing: Bool)

    func initiatePayTMWebOnlinePayment(orderId: String, paymentInitResponse: PaymentInitResponse)
    
    func initiateRazorOnlinePayment(orderId: String, phone: String, responseDict: OrderResponse?, paymentInitResponse: PaymentInitResponse)
    
    func initiatePaytabsOnlinePayment(orderId: String, phone: String, responseDict: OrderResponse?, paymentInitResponse: PaymentInitResponse)
    
    func initiateSimplPayment(orderId: String, phone: String, transactionId: String)
    
    func showOrderConfirmationAlert(orderId: String)
    
    func handleOrderPayment(isOrderPaymentError: Bool, error: UPError?)
    
    func handleApplyCoupon(code: String, error: UPError?)
}

public class OrderPaymentDataModel: UrbanPiperDataModel {
    
    public var checkoutBuilder: CheckoutBuilder = UrbanPiperSDK.shared.startCheckout()
        
//    public var preProcessOrderResponse: PreProcessOrderResponse? {
//        didSet {
//            guard preProcessOrderResponse != nil else { return }
//            applyWalletCredits = preProcessOrderResponse?.order.walletCreditApplicable ?? false
//
//            if selectedPaymentOption == .select, selectedPaymentOption != defaultPaymentOption {
//                selectedPaymentOption = defaultPaymentOption
//            }
//
//            if applyCouponResponse != nil && couponCode != nil {
//                let code = couponCode!
//                let isSuggested = isSuggestedCoupon
//                DispatchQueue.main.async { [weak self] in
//                    self?.applyCoupon(code: code, isSuggested: isSuggested, preSelected: code == CartManager.shared.couponCodeToApply)
//                    self?.couponCode = nil
//                    self?.applyCouponResponse = nil
//                }
//            } else {
//                couponCode = nil
//                applyCouponResponse = nil
//            }
//        }
//    }
    
    public var bizInfo: UserBizInfoResponse? {
        didSet {
            guard oldValue == nil && bizInfo != nil else { return }
            selectedDeliveryOption = OrderingStoreDataModel.shared.deliveryOption// defaultDeliveryOption
        }
    }
    
    public var deliveryAddress: Address?
//    {
//        guard let defaultAddressData: Data = UserDefaults.standard.object(forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey) as? Data else { return nil }
//            Address.registerClass()
//        guard let address: Address = NSKeyedUnarchiver.unarchiveObject(with: defaultAddressData) as? Address else { return nil }
//        return address
//    }

//    public var couponCode: String?
    public var isSuggestedCoupon: Bool = false
//    public var applyCouponResponse: Order?
    
    public var applyWalletCredits: Bool = AppConfigManager.shared.firRemoteConfigDefaults.applyWalletCredits

    weak public var dataModelDelegate: OrderPaymentDataModelDelegate?
    
    public var orderResponse: Order? {
        return checkoutBuilder.order
    }
    
//    public var itemsPrice: Decimal {
//        return orderResponse?.orderSubtotal ?? CartManager.shared.cartValue
//    }
//    
//    public var deliveryCharge: Decimal {
//        return orderResponse?.deliveryCharge ?? OrderingStoreDataModel.shared.orderingStore?.deliveryCharge ?? Decimal.zero
//    }
//    
//    public var packagingCharge: Decimal? {
//        return orderResponse?.packagingCharge ?? OrderingStoreDataModel.shared.orderingStore?.packagingCharge
//    }
//    
//    public var discountPrice: Decimal? {
//        return applyCouponResponse?.discount?.value ?? preProcessOrderResponse?.order.discount?.value ?? OrderingStoreDataModel.shared.orderingStore?.discount
//    }
//
//    public var itemsTotalPrice: Decimal {
//        return checkoutBuilder.order?.payableAmount ?? CartManager.shared.cartValue
//    }
//
//    public var itemTaxes: Decimal? {
//        return orderResponse?.itemTaxes ?? OrderingStoreDataModel.shared.orderingStore?.itemTaxes
//    }
//    
//    public var taxRate: Float {
//        return orderResponse?.taxRate ?? OrderingStoreDataModel.shared.orderingStore?.taxRate ?? 0
//    }

    public var selectedPaymentOption: PaymentOption = .select
    
    private var defaultPaymentOption: PaymentOption {
//        if let option: Bool = AppConfigManager.shared.firRemoteConfigDefaults.forcePaymentOptSel, option {
//            return .select
//        } else
        if let paymentOption = paymentOptions?.first {
            return paymentOption
        } else {
            return .select
        }
    }
    
    lazy public var selectedDeliveryOption: DeliveryOption = {
        return OrderingStoreDataModel.shared.deliveryOption// defaultDeliveryOption
    }()
    
//    private var defaultDeliveryOption: DeliveryOption {
//        switch OrderingStoreDataModel.shared.deliveryOption {
//        case .delivery:
//            if let deliveryOption = deliveryOptions?.first {
//                return deliveryOption
//            }
//            return .delivery
//        case .pickUp:
//            return .pickUp
//        }
//    }
    
    lazy public var selectedDeliveryTimeSlotOption: TimeSlot? = {
        guard let deliveryTimeSlotOption = deliverySlotsOptions.first else { return nil }
            return deliveryTimeSlotOption
    }()
    
    lazy public var selectedRequestedTime: Date? = defaultOrderDeliveryDateTime
    
    lazy public var selectedRequestedDate: Date = Date()
    
    public var deliveryDateTime: Date? {
        guard var deliveryTime = selectedRequestedTime else { return nil }

        if let optimalDeliveryTime = defaultOrderDeliveryDateTime, deliveryTime < optimalDeliveryTime {
            deliveryTime = optimalDeliveryTime
        }

        var units: Set<Calendar.Component> = [.day, .month, .year]
        var comps: DateComponents = Calendar.current.dateComponents(units, from: selectedRequestedDate)
        let day: Date = Calendar.current.date(from: comps)!

        units = [.hour, .minute, .second]
        comps = Calendar.current.dateComponents(units, from: deliveryTime)

        return Calendar.current.date(byAdding: comps, to: day)!
    }
    
    public var normalDefaultOrderDeliveryDate: Date? {
        let paymentOffsetTimeSecs: TimeInterval = TimeInterval(120)
        let defaultOffset: TimeInterval = selectedDeliveryOption.deliveryOptionOffsetTimeSecs
        // around 2 minutes gap to payment
        var normalDeliveryDate: Date? = Date().addingTimeInterval(paymentOffsetTimeSecs + defaultOffset)

        let openingDate: Date = OrderingStoreDataModel.shared.orderingStore!.openingDate!
        let openingDateWithOffset: Date = openingDate.addingTimeInterval(defaultOffset)

        let closingDate: Date = OrderingStoreDataModel.shared.orderingStore!.closingDate!
//        let closingDateWithOffset: Date = closingDate.addingTimeInterval(-(paymentOffsetTimeSecs + defaultOffset))
        
        if normalDeliveryDate! < openingDateWithOffset {
            normalDeliveryDate = openingDateWithOffset
        } else if normalDeliveryDate! > closingDate {
            normalDeliveryDate = nil
        }
        
        return normalDeliveryDate
    }
    
    public var defaultOrderDeliveryDateTime: Date? {
        guard let normalOrderDate = normalDefaultOrderDeliveryDate else { return nil }
        let preOrderDate = CartManager.shared.cartPreOrderStartTime
        if let date = preOrderDate, date > normalOrderDate {
            return date
        }
        return normalOrderDate
    }

    public var deliveryOptions: [DeliveryOption]? {
        guard let isPickupEnabled = OrderingStoreDataModel.shared.nearestStoreResponse?.biz.isPickupEnabled ?? Biz.shared?.isPickupEnabled else { return nil }
        var array = [DeliveryOption]()
        
        array.append(.delivery)
        
        if isPickupEnabled {
            array.append(.pickUp)
        }
        return array
    }
    
    public var simpl: Simpl?

    public var phoneNumber: String?
    
    public var paymentOptions: [PaymentOption]? {
        guard var paymentArray = checkoutBuilder.getPaymentModes else { return nil }
        
        // Removing wallet option
        if !AppConfigManager.shared.firRemoteConfigDefaults.moduleWallet {
            paymentArray = paymentArray.filter { $0 != .prepaid }
        }

        // Removing cash option
        if !AppConfigManager.shared.firRemoteConfigDefaults.allowCashForOrderCheckout {
            paymentArray = paymentArray.filter { $0 != .cash }
        }

        if simpl == nil || !simpl!.isAuthorized {
            paymentArray = paymentArray.filter { $0 != .simpl }
        }

        // Removing paypal option
        paymentArray = paymentArray.filter { $0 != .paypal }

        if let paymentOptionString: String = AppConfigManager.shared.firRemoteConfigDefaults.dfltPymntOpt,
            let option: PaymentOption = PaymentOption(rawValue: paymentOptionString) {
            let defaultOptionPresent = paymentArray.filter { $0 == option }.count > 0
            
            paymentArray = paymentArray.filter { $0 != option }
            
            if defaultOptionPresent {
                paymentArray.insert(option, at: 0)
            }
        }

        return paymentArray
    }
    
    public var deliverySlotsOptions: [TimeSlot] {
        guard AppConfigManager.shared.firRemoteConfigDefaults.enableTimeSlots else { return [] }
        let storeTimeSlots = OrderingStoreDataModel.shared.orderingStore?.timeSlots
        guard let availableTimeSlots = storeTimeSlots?.isEmpty == false ? storeTimeSlots : Biz.shared?.timeSlots, availableTimeSlots.count > 0 else { return [] }
        
        let dayName = selectedRequestedDate.dayName
        
        var filteredSlots = [TimeSlot]()
        
        if let startTime = CartManager.shared.cartPreOrderStartTime {
            filteredSlots = availableTimeSlots.filter { $0.day == dayName && $0.startTime!.currentDateTime! >= startTime }
        } else if Calendar.current.isDateInToday(selectedRequestedDate) {
            guard let defaultDate = defaultOrderDeliveryDateTime else { return filteredSlots }
            filteredSlots = availableTimeSlots.filter { $0.day == dayName && $0.endTime!.currentDateTime! >= defaultDate }
        } else {
            filteredSlots = availableTimeSlots.filter { $0.day == dayName }
        }
        
        if filteredSlots.count > 1 {
            filteredSlots.sort { $0.startTime!.currentDateTime! < $1.startTime!.currentDateTime! }
        }
        
        return filteredSlots
    }
    
//    public var globalCouponApplied: Bool = false
    
    public func refreshData() {
        guard UserManager.shared.currentUser != nil else { return }

//        if isForcedRefresh ||
            if bizInfo == nil {
            bizInfo = nil
            updateUserBizInfo()
        }

//        if isForcedRefresh ||
            if checkoutBuilder.order == nil || (selectedDeliveryOption == .pickUp && (checkoutBuilder.order?.deliveryCharge ?? Decimal.zero) > Decimal.zero) {
//            preProcessOrderResponse = nil
            preProcessOrder()
        }

    }

    public override init() {
        super.init()

        UserManager.shared.addObserver(delegate: self)
    }

}

//  MARK: API Calls

extension OrderPaymentDataModel {
    
    public func preProcessOrder() {
        dataModelDelegate?.refreshPreProcessingUI(true)
        
        let isFirstPreProcessingCall: Bool = checkoutBuilder.order == nil
                
        let dataTask: URLSessionDataTask = checkoutBuilder.validateCart(store: OrderingStoreDataModel.shared.orderingStore!,
                                                                        useWalletCredits: applyWalletCredits,
                                                                        deliveryOption: selectedDeliveryOption,
                                                                        cartItems: CartManager.shared.cartItems,
                                                                        orderTotal: CartManager.shared.cartValue,
                                                                        completion:
            { [weak self] (preProcessOrderResponse) in
                defer {
                    self?.dataModelDelegate?.refreshPreProcessingUI(false)
                }
                guard let order = preProcessOrderResponse?.order else { return }
                if isFirstPreProcessingCall {
                    AnalyticsManager.shared.track(event: .checkoutInit(payableAmt: order.payableAmount, walletCreditsApplied: order.walletCreditApplicable ?? false))
                }

                self?.applyWalletCredits = preProcessOrderResponse?.order.walletCreditApplicable ?? false
                
                if  let defaultPaymentOption = self?.defaultPaymentOption, self?.selectedPaymentOption == nil {
                    self?.selectedPaymentOption = defaultPaymentOption
                }
                if let currentPaymentOption = self?.selectedPaymentOption, let defaultPaymentOption = self?.defaultPaymentOption,
                    currentPaymentOption == .select, currentPaymentOption != defaultPaymentOption {
                    self?.selectedPaymentOption = defaultPaymentOption
                }
                
                guard let code = self?.checkoutBuilder.couponCode, let isSuggested = self?.isSuggestedCoupon, let preSelected = CartManager.shared.couponCodeToApply else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.applyCoupon(code: code, isSuggested: isSuggested, preSelected: code == CartManager.shared.couponCodeToApply)
                    self?.checkoutBuilder.clearCoupon()
//                    self?.applyCouponResponse = nil
                }
            }, failure: { [weak self] (upError) in
                defer {
                    self?.dataModelDelegate?.refreshPreProcessingUI(false)
                    self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: true, error: upError)
                }
        })
        addDataTask(dataTask: dataTask)
    }
    
    fileprivate func updateUserBizInfo() {
        dataModelDelegate?.refreshWalletUI(true)
        UserManager.shared.refreshUserBizInfo(completion: { [weak self] (info) in
            defer {
                self?.dataModelDelegate?.refreshWalletUI(false)
            }
            self?.bizInfo = info
        }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.refreshWalletUI(false)
                self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: upError)
            }
        })
    }
    
    public func applyCoupon(code: String, isSuggested: Bool, preSelected: Bool) {
        guard code.count > 0 else { return }
//        let orderDict: [String: Any] = ["biz_location_id": OrderingStoreDataModel.shared.orderingStore!.bizLocationId,
//                         "order_type": selectedDeliveryOption.rawValue,
//                         "channel": APIManager.channel,
//                         "items": CartManager.shared.cartItems.map { $0.toDictionary() },
//                         "apply_wallet_credit": applyWalletCredits] as [String: Any]
        
        dataModelDelegate?.refreshApplyCouponUI(true, code: code)
        let dataTask: URLSessionDataTask? = checkoutBuilder.validateCoupon(code: code,
                                                                          completion:
            { [weak self] (applyCouponResponse) in
                if let discount = applyCouponResponse?.discount, discount.success {
//                    if let globalCoupon = CartManager.shared.couponCodeToApply, globalCoupon == code {
//                        self?.globalCouponApplied = true
//                    } else {
//                        self?.globalCouponApplied = false
//                    }


//                    self?.applyCouponResponse = applyCouponResponse
//                    self?.couponCode = code
                    self?.isSuggestedCoupon = isSuggested
                    self?.dataModelDelegate?.refreshApplyCouponUI(false, code: code)
                    
                    AnalyticsManager.shared.track(event: .couponSuccess(discount: discount.value!, couponCode: code, isSuggested: isSuggested, preSelected: preSelected))
                } else {
//                    if let globalCoupon = CartManager.shared.couponCodeToApply, globalCoupon == code {
//                        self?.globalCouponApplied = false
//                    }
                    let upApiError = UPAPIError(responseObject: applyCouponResponse?.discount?.toDictionary())
                    self?.dataModelDelegate?.handleApplyCoupon(code: code, error: upApiError)
                    AnalyticsManager.shared.track(event: .couponFailed(discount: Decimal.zero, couponCode: code, isSuggested: isSuggested, preSelected: preSelected))
                    
                }

                }, failure: { [weak self] (upError) in
                    defer {
                        self?.dataModelDelegate?.refreshApplyCouponUI(false, code: code)
                        self?.dataModelDelegate?.handleApplyCoupon(code: code, error: upError)
                    }
//                    if let globalCoupon = CartManager.shared.couponCodeToApply, globalCoupon == code {
//                        self?.globalCouponApplied = false
//                    }
                    AnalyticsManager.shared.track(event: .couponFailed(discount: Decimal.zero, couponCode: code, isSuggested: isSuggested, preSelected: preSelected))
                })
        addDataTask(dataTask: dataTask)
    }
    
    public func payOnlineAndPlaceOrder(instructions: String,
                                phone: String) {
        let paymentOption = selectedPaymentOption
        let dataTask: URLSessionDataTask? = checkoutBuilder.initPayment(paymentOption: paymentOption,
                                                                        completion:
            { [weak self] (paymentInitResponse) in
                self?.dataModelDelegate?.initiatingPayment(isProcessing: false)
                if paymentOption == .paymentGateway || paymentOption == .paytm || paymentOption == .simpl {
                    self?.placeOrder(instructions: instructions, phone: phone, paymentInitResponse: paymentInitResponse)
                }
        }, failure: { [weak self] (error) in
            self?.dataModelDelegate?.initiatingPayment(isProcessing: false)
            self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: error)
        })

        addDataTask(dataTask: dataTask)
        
        guard dataTask == nil else { return }
        dataModelDelegate?.initiatingPayment(isProcessing: true)
    }
        
    public func placeOrder(instructions: String,
                    phone: String,
                    paymentInitResponse: PaymentInitResponse? = nil) {
        
        let timeSlotDelivery: Bool = AppConfigManager.shared.firRemoteConfigDefaults.enableTimeSlots
        
        let paymentOption = selectedPaymentOption
        let dataTask: URLSessionDataTask? = checkoutBuilder.placeOrder(address: selectedDeliveryOption != .pickUp ? deliveryAddress : nil,
                                                                       deliveryDate: selectedRequestedDate,
                                                                       deliveryTime: selectedRequestedTime!,
                                                                       timeSlot: timeSlotDelivery ? selectedDeliveryTimeSlotOption : nil,
                                                                       paymentOption: paymentOption,
                                                                       instructions: instructions,
                                                                       phone: phone,
                                                                       completion:
            { [weak self] (response) in
                self?.dataModelDelegate?.placingOrder(isProcessing: false)
                guard let orderId = response?.orderId, let status = response?.status, status == "success" else {
                    let error: UPAPIError? = UPAPIError(responseObject: response?.toDictionary())
                    self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: error)
                    return
                }
                
                if paymentOption == .paymentGateway {
                    let paymentGateway = PaymentGateway(rawValue: Biz.shared!.pgProvider)!
                    switch paymentGateway {
                    case .razorpay:
                        self?.dataModelDelegate?.initiateRazorOnlinePayment(orderId: orderId, phone: phone, responseDict: response, paymentInitResponse: paymentInitResponse!)
                    case .paytabs:
                        self?.dataModelDelegate?.initiatePaytabsOnlinePayment(orderId: orderId, phone: phone, responseDict: response, paymentInitResponse: paymentInitResponse!)
                    }
                } else if paymentOption == .paytm {
                    self?.dataModelDelegate?.initiatePayTMWebOnlinePayment(orderId: orderId, paymentInitResponse: paymentInitResponse!)
                } else if paymentOption == .simpl {
                    self?.dataModelDelegate?.initiateSimplPayment(orderId: orderId, phone: phone, transactionId: paymentInitResponse!.transactionId)
                } else {
                    self?.orderPlacedTracking(orderId: orderId, phone: phone)
                    self?.dataModelDelegate?.showOrderConfirmationAlert(orderId: orderId)
                }
            }, failure: { [weak self] (error) in
                self?.dataModelDelegate?.placingOrder(isProcessing: false)
                self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: error)
        })
        
        addDataTask(dataTask: dataTask)
        
        guard dataTask == nil else { return }
        dataModelDelegate?.placingOrder(isProcessing: true)
    }
    
}

extension OrderPaymentDataModel {
    
    public func verifyTransaction(paymentId: String, phone: String, orderId: String, transactionId: String) {
        dataModelDelegate?.verifyingTransaction(isProcessing: true)
        orderPlacedTracking(orderId: orderId, phone: phone)

        let dataTask: URLSessionDataTask? = checkoutBuilder.verifyPayment(pid: paymentId,
                                                                         completion:
            { [weak self] (response) in
                self?.dataModelDelegate?.verifyingTransaction(isProcessing: false)
                if let status: String = response?.status, status == "3" {
                    self?.dataModelDelegate?.showOrderConfirmationAlert(orderId: orderId)
                } else {
                    let upError: UPError = UPError(type: .paymentFailure("There appears to have been some error in processing your transaction. Please try placing the order again. If you believe the payment has been made, please don\'t worry since we\'ll have it refunded, once we get a confirmation."))
                    self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false,
                                                                error: upError)
                }
            }, failure: { [weak self] (error) in
                self?.dataModelDelegate?.verifyingTransaction(isProcessing: false)
                self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: error)
        })
        
        addDataTask(dataTask: dataTask)
    }
    

    public func orderPlacedTracking(orderId: String, phone: String) {
//        orderPaymentDataModel.itemsTotalPrice as NSNumber).build() as! [AnyHashable : Any]
//        tracker.send(eventDictionary)
//
//        let eventBuilder = GAIDictionaryBuilder.createEvent(withCategory: nil, action: nil, label: nil, value: nil)!
//
//        let productAction: GAIEcommerceProductAction = GAIEcommerceProductAction()
//        productAction.setAction(kGAIPAPurchase)
//        productAction.setTransactionId(orderID)
//        productAction.setAffiliation("UrbanPiper")
//        productAction.setRevenue(NSDecimalNumber(decimal: orderPaymentDataModel.itemsTotalPrice))
//        productAction.setTax(NSDecimalNumber(decimal: orderPaymentDataModel.itemTaxes ?? Decimal.zero))
//
//        let deliveryCharge = orderPaymentDataModel.selectedDeliveryOption == .pickUp ? Decimal.zero : orderPaymentDataModel.deliveryCharge
//        productAction.setShipping(NSDecimalNumber(decimal: deliveryCharge))
//        productAction.setCheckoutOption(orderPaymentDataModel.selectedPaymentOption.rawValue)
//
//        let couponCode = orderPaymentDataModel.applyCouponResponse != nil ? orderPaymentDataModel.couponCode : nil
//        productAction.setCouponCode(couponCode)
//
//        if let items = orderPaymentDataModel.orderResponse?.items {
//            for item in items {
//                let product: GAIEcommerceProduct = GAIEcommerceProduct()
//                product.setId("\(item.id!)")
//                product.setName(item.itemTitle)
//                product.setQuantity(NSNumber(value: item.quantity))
//                product.setPrice(NSDecimalNumber(decimal: item.itemPrice))
//                product.setCategory(item.category.name)
//
//                eventBuilder.add(product)
//            }
//        }
        
        AnalyticsManager.shared.track(event: .purchaseCompleted(orderID: orderId,
                                                                userWalletBalance: bizInfo?.userBizInfos.last?.balance.decimalValue ?? Decimal.zero,
                                                                checkoutBuilder: checkoutBuilder,
                                                                isReorder: CartManager.shared.isReorder))
    }

}

extension OrderPaymentDataModel: UserManagerDelegate {
    
    public func userBizInfoChanged() {
        bizInfo = UserManager.shared.currentUser?.userBizInfoResponse
        dataModelDelegate?.refreshWalletUI(false)
    }

}

//  App State Management

extension OrderPaymentDataModel {
    
    @objc open override func appWillEnterForeground() {
        refreshData()
    }
    
    @objc open override func appDidEnterBackground() {
        
    }
    
}

//  Reachability

extension OrderPaymentDataModel {
    
    @objc open override func networkIsAvailable() {
        refreshData()
    }
    
    @objc open override func networkIsDown() {
        
    }
}
