//
//  OrderPaymentDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

public enum PaymentOption: String {
    case cash = "cash"
    case prepaid = "prepaid"
    case paymentGateway = "payment_gateway"
    case paytm = "paytm"
    case simpl = "simpl"
    case paypal = "paypal"
    case select = "select"
    
    public var displayName: String {
        switch self {
        case .cash:
            return "Cash on delivery"
        case .prepaid:
            return "Wallet"
        case .paymentGateway:
            return "Pay online"
        case .paytm:
            return "PAYTM"
        case .simpl:
            return "Simpl"
        case .paypal:
            return "Paypal"
        case .select:
            return "SELECT OPTION"
        }
    }
}

public enum DeliveryOption: String {
    
    case delivery = "delivery"
    case pickUp = "pickup"
    
    public func displayName(orderAmount: Decimal?) -> String {
        switch self {
        case .delivery:
            if let amount = orderAmount, amount > 0.0 {
                let currencySymbol: String = AppConfigManager.shared.firRemoteConfigDefaults.lblCurrencySymbol!
                return "DELIVERY (MIN ORDER \(currencySymbol) \(amount.stringVal))"
            }
            return "DELIVERY"
        case .pickUp:
            return "PICKUP"
        }
    }
}

@objc public protocol OrderPaymentDataModelDelegate {
    
    func refreshPreProcessingUI(_ isRefreshing: Bool)
    func refreshWalletUI(_ isRefreshing: Bool)
    
    @objc func refreshApplyCouponUI(_ isRefreshing: Bool, code: String)
    
    func initiatingPayment(isProcessing: Bool)
    
    func placingOrder(isProcessing: Bool)
    
    func verifyingTransaction(isProcessing: Bool)

    func initiatePayTMWebOnlinePayment(orderId: String, onlinePaymentInitResponse: OnlinePaymentInitResponse)
    
    func initiateRazorOnlinePayment(orderId: String, phone: String, responseDict: [String: Any], onlinePaymentInitResponse: OnlinePaymentInitResponse)
    
    func initiateSimplPayment(orderId: String, phone: String, transactionId: String)
    
    func showOrderConfirmationAlert(orderId: String)
    
    func handleOrderPayment(isOrderPaymentError: Bool, error: UPError?)
    
    func handleApplyCoupon(code: String, error: UPError?)
}

public class OrderPaymentDataModel: UrbanPiperDataModel {
        
    public var orderPreProcessingResponse: OrderPreProcessingResponse? {
        didSet {
            guard orderPreProcessingResponse != nil else { return }
            applyWalletCredits = orderPreProcessingResponse?.order.walletCreditApplicable ?? false
            
            if applyCouponResponse != nil && couponCode != nil {
                let code = couponCode!
                DispatchQueue.main.async { [weak self] in
                    self?.applyCoupon(code: code)
                    self?.couponCode = nil
                    self?.applyCouponResponse = nil
                }
            } else {
                couponCode = nil
                applyCouponResponse = nil
            }
        }
    }
    
    public var bizInfo: BizInfo? {
        didSet {
            guard oldValue == nil && bizInfo != nil else { return }
            selectedDeliveryOption = defaultDeliveryOption
        }
    }
    
    public var deliveryAddress: Address?
//    {
//        guard let defaultAddressData: Data = UserDefaults.standard.object(forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey) as? Data else { return nil }
//            Address.registerClassName()
//        guard let address: Address = NSKeyedUnarchiver.unarchiveObject(with: defaultAddressData) as? Address else { return nil }
//        return address
//    }

    public var couponCode: String?
    public var applyCouponResponse: Order?
    
    public var applyWalletCredits: Bool = AppConfigManager.shared.firRemoteConfigDefaults.applyWalletCredits

    weak public var dataModelDelegate: OrderPaymentDataModelDelegate?
    
    public var orderResponse: Order? {
        return applyCouponResponse ?? orderPreProcessingResponse?.order
    }
    
    public var itemsPrice: Decimal {
        return orderResponse?.orderSubtotal ?? CartManager.shared.cartValue
    }
    
    public var deliveryCharge: Decimal {
        return orderResponse?.deliveryCharge ?? OrderingStoreDataModel.shared.orderingStore?.deliveryCharge ?? Decimal.zero
    }
    
    public var packagingCharge: Decimal? {
        return orderResponse?.packagingCharge ?? OrderingStoreDataModel.shared.orderingStore?.packagingCharge
    }
    
    public var discountPrice: Decimal? {
        return applyCouponResponse?.discount.value ?? orderPreProcessingResponse?.discount ?? OrderingStoreDataModel.shared.orderingStore?.discount
    }

    public var itemsTotalPrice: Decimal {
        return orderResponse?.payableAmount ?? CartManager.shared.cartValue
    }
    
    public var itemTaxes: Decimal? {
        return orderResponse?.itemTaxes ?? OrderingStoreDataModel.shared.orderingStore?.itemTaxes
    }
    
    public var taxRate: Float {
        return orderResponse?.taxRate ?? OrderingStoreDataModel.shared.orderingStore?.taxRate ?? 0
    }

    lazy public var selectedPaymentOption: PaymentOption = {
        return defaultPaymentOption
    }()
    
    private var defaultPaymentOption: PaymentOption {
        if let option: Bool = AppConfigManager.shared.firRemoteConfigDefaults.forcePaymentOptSel, option {
            return .select
        } else if let paymentOption = paymentOptions?.first {
            return paymentOption
        } else {
            return .select
        }
    }
    
    lazy public var selectedDeliveryOption: DeliveryOption = {
        return defaultDeliveryOption
    }()
    
    private var defaultDeliveryOption: DeliveryOption {
        switch OrderingStoreDataModel.shared.deliveryOption {
        case .delivery:
            if let deliveryOption = deliveryOptions?.first {
                return deliveryOption
            }
            return .delivery
        case .pickUp:
            return .pickUp
        }
    }
    
    lazy public var selectedDeliveryTimeSlotOption: TimeSlot? = {
        guard let deliveryTimeSlotOption = deliverySlotsOptions?.first else { return nil }
            return deliveryTimeSlotOption
    }()
    
    lazy public var selectedRequestedTime: Date = defaultOrderDeliveryDateTime
    
    lazy public var selectedRequestedDate: Date = defaultOrderDeliveryDateTime
    
    public var deliveryDate: Date {
        var units: Set<Calendar.Component> = [.day, .month, .year]
        var comps: DateComponents = Calendar.current.dateComponents(units, from: selectedRequestedDate)
        let day: Date = Calendar.current.date(from: comps)!
        
        units = [.hour, .minute, .second]
        comps = Calendar.current.dateComponents(units, from: selectedRequestedTime)
        
        return Calendar.current.date(byAdding: comps, to: day)!
    }
    
    public var normalDefaultOrderDeliveryDate: Date {
        let delMinOffset: TimeInterval = TimeInterval(Biz.shared!.deliveryMinOffsetTime)
        let defaultOffset: TimeInterval = TimeInterval(100000.0)
        // around 2 minutes gap to payment
        let normalDeliveryDate: Date = Date().addingTimeInterval(((delMinOffset + defaultOffset) / 1000.0))
        return normalDeliveryDate
    }
    
    public var defaultOrderDeliveryDateTime: Date {
        let normalOrderDDate = normalDefaultOrderDeliveryDate
        let preOrderDDate = CartManager.shared.cartPreOrderStartTime
        if let date = preOrderDDate, date > normalOrderDDate {
            return date
        }
        return normalOrderDDate
    }

    public var deliveryOptions: [DeliveryOption]? {
        guard let bizDetails = OrderingStoreDataModel.shared.nearestStoreResponse?.biz else { return nil }
        var array = [DeliveryOption]()
        
        array.append(.delivery)
        
        if bizDetails.isPickupEnabled {
            array.append(.pickUp)
        }
        return array
    }
    
    public var simpl: Simpl?

    public var phoneNumber: String?
    
    public var paymentOptions: [PaymentOption]? {
        guard let paymentsStringArray = orderPreProcessingResponse?.order.paymentModes else { return nil }
        
        var paymentArray: [PaymentOption] = paymentsStringArray.compactMap { PaymentOption(rawValue: $0) }
        
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
    
    public var deliverySlotsOptions: [TimeSlot]? {
        guard AppConfigManager.shared.firRemoteConfigDefaults.enableTimeSlots else { return nil }
        guard let availableTimeSlots = Biz.shared?.timeSlots, availableTimeSlots.count > 0 else { return nil }

        let date = defaultOrderDeliveryDateTime
        
        let dayName = date.dayName
        
        var filteredSlots = [TimeSlot]()
        
        if let startTime = CartManager.shared.cartPreOrderStartTime {
            filteredSlots = availableTimeSlots.filter { $0.day == dayName && $0.startTime!.currentDateTime! >= startTime }
        }
        else if Calendar.current.isDateInToday(date) {
            filteredSlots = availableTimeSlots.filter { $0.day == dayName && $0.endTime!.currentDateTime! >= date }
        }
        else if date < Date() {
            filteredSlots = availableTimeSlots.filter { $0.day == dayName }
        }
        
        if filteredSlots.count > 1 {
            filteredSlots.sort { $0.startTime!.currentDateTime! < $1.startTime!.currentDateTime! }
        }
        
        return filteredSlots
    }
    
    public var globalCouponApplied: Bool = false
        
    public func refreshData(_ isForcedRefresh: Bool = false) {
        guard AppUserDataModel.shared.validAppUserData != nil else { return }

        if isForcedRefresh || bizInfo == nil {
            bizInfo = nil
            updateUserBizInfo()
        }

        if isForcedRefresh || orderPreProcessingResponse == nil {
            orderPreProcessingResponse = nil
            preProcessOrder()
        }

    }

    public override init() {
        super.init()

        refreshData()
        AppUserDataModel.shared.addObserver(delegate: self)
    }

}

//  MARK: API Calls

extension OrderPaymentDataModel {
    
    public func preProcessOrder() {
        dataModelDelegate?.refreshPreProcessingUI(true)
                
        let dataTask: URLSessionDataTask = APIManager.shared.preProcessOrder(bizLocationId: OrderingStoreDataModel.shared.orderingStore!.bizLocationId,
                                                         applyWalletCredit: applyWalletCredits,
                                                         deliveryOption: selectedDeliveryOption.rawValue,
                                                         items: CartManager.shared.cartItems,
                                                         orderTotal: itemsTotalPrice,
                                                         completion: { [weak self] (orderPreProcessingResponse) in
            defer {
                self?.dataModelDelegate?.refreshPreProcessingUI(false)
            }
            self?.orderPreProcessingResponse = orderPreProcessingResponse
            }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.refreshPreProcessingUI(false)
                self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: true, error: upError)
            }
        })
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    fileprivate func updateUserBizInfo() {
        dataModelDelegate?.refreshWalletUI(true)
        let dataTask: URLSessionDataTask = APIManager.shared.fetchBizInfo(completion: { [weak self] (info) in
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
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func applyCoupon(code: String) {
        guard code.count > 0 else { return }
        let orderDict: [String: Any] = ["biz_location_id": OrderingStoreDataModel.shared.orderingStore!.bizLocationId,
                         "order_type": selectedDeliveryOption.rawValue,
                         "channel": APIManager.channel,
                         "items": CartManager.shared.cartItems.map { $0.discountCouponApiItemDictionary },
                         "apply_wallet_credit": applyWalletCredits] as [String : Any]
        
        dataModelDelegate?.refreshApplyCouponUI(true, code: code)
        let dataTask: URLSessionDataTask = APIManager.shared.applyCoupon(code: code,
                                                     orderData: orderDict,
                                                     completion:
            { [weak self] (applyCouponResponse) in
                if let discount = applyCouponResponse?.discount, discount.success {
                    if let globalCoupon = CartManager.shared.couponCodeToApply, globalCoupon != code {
                        self?.globalCouponApplied = false
                    } else {
                        self?.globalCouponApplied = true
                    }


                    self?.applyCouponResponse = applyCouponResponse
                    self?.couponCode = code
                    self?.dataModelDelegate?.refreshApplyCouponUI(false, code: code)
                    
                    AnalyticsManager.shared.couponApplied(discount: discount.value!, couponCode: code)
                } else {
                    if let globalCoupon = CartManager.shared.couponCodeToApply, globalCoupon == code {
                        self?.globalCouponApplied = false
                    }
                    let upApiError = UPAPIError(error: nil, data: nil, responseObject: applyCouponResponse?.discount.toDictionary())
                    self?.dataModelDelegate?.handleApplyCoupon(code: code, error: upApiError)
                    AnalyticsManager.shared.couponApplyFailed(couponCode: code)
                }

                }, failure: { [weak self] (upError) in
                    defer {
                        self?.dataModelDelegate?.refreshApplyCouponUI(false, code: code)
                        self?.dataModelDelegate?.handleApplyCoupon(code: code, error: upError)
                    }
                    if let globalCoupon = CartManager.shared.couponCodeToApply, globalCoupon == code {
                        self?.globalCouponApplied = false
                    }
                    AnalyticsManager.shared.couponApplyFailed(couponCode: code)
                })
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func payOnlineAndPlaceOrder(instructions: String,
                                phone: String) {
        dataModelDelegate?.initiatingPayment(isProcessing: true)
        let paymentOption = selectedPaymentOption
        let dataTask: URLSessionDataTask? = APIManager.shared.initiateOnlinePayment(paymentOption: paymentOption,
                                                               purpose: OnlinePaymentPurpose.ordering,
                                                               totalAmount: itemsTotalPrice,
                                                               bizLocationId: OrderingStoreDataModel.shared.orderingStore!.bizLocationId,
                                                               completion: { [weak self] (onlinePaymentInitResponse) in
                                                                self?.dataModelDelegate?.initiatingPayment(isProcessing: false)
                                                                if paymentOption == .paymentGateway || paymentOption == .paytm || paymentOption == .simpl {
                                                                    self?.placeOrder(instructions: instructions, phone: phone, onlinePaymentInitResponse: onlinePaymentInitResponse)
                                                                }
        }, failure: { [weak self] (error) in
            self?.dataModelDelegate?.initiatingPayment(isProcessing: false)
            self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: error)
        })

        guard let task = dataTask else { return }
        addOrCancelDataTask(dataTask: task)
    }
        
    public func placeOrder(instructions: String,
                    phone: String,
                    onlinePaymentInitResponse: OnlinePaymentInitResponse? = nil) {
        
        dataModelDelegate?.placingOrder(isProcessing: true)
        
        let timeSlotDelivery: Bool = AppConfigManager.shared.firRemoteConfigDefaults.enableTimeSlots!
        
        let paymentOption = selectedPaymentOption
        let dataTask: URLSessionDataTask = APIManager.shared.placeOrder(address: selectedDeliveryOption != .pickUp ? deliveryAddress : nil,
                                     items: CartManager.shared.cartItems,
                                     deliveryDate: deliveryDate,
                                     timeSlot: timeSlotDelivery ? selectedDeliveryTimeSlotOption : nil,
                                     deliveryOption: selectedDeliveryOption.rawValue,
                                     phone: phone,
                                     bizLocationId: OrderingStoreDataModel.shared.orderingStore!.bizLocationId,
                                     paymentOption: paymentOption.rawValue,
                                     taxRate: taxRate,
                                     couponCode: couponCode,
                                     deliveryCharge: deliveryCharge,
                                     discountApplied: discountPrice ?? 0,
                                     itemTaxes: itemTaxes ?? 0,
                                     packagingCharge: packagingCharge ?? 0,
                                     orderSubTotal: itemsPrice,
                                     orderTotal: itemsTotalPrice,
                                     applyWalletCredit: applyWalletCredits,
                                     walletCreditApplied: orderPreProcessingResponse?.order.walletCreditApplied ?? Decimal.zero,
                                     payableAmount: itemsTotalPrice,
                                     onlinePaymentInitResponse: onlinePaymentInitResponse,
                                     completion: { [weak self] (responseDict) in
                                        self?.dataModelDelegate?.placingOrder(isProcessing: false)
                                        guard let orderId = responseDict?["order_id"] else {
                                            let error: UPAPIError? = UPAPIError(responseObject: responseDict)
                                            self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: error)
                                            return
                                        }
                                        let orderIdString: String = "\(orderId)"
                                        
                                        guard orderIdString.count > 0 else {
                                            let error: UPAPIError? = UPAPIError(responseObject: responseDict)
                                            self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: error)
                                            return
                                        }

                                        if paymentOption == .paymentGateway {
                                            self?.dataModelDelegate?.initiateRazorOnlinePayment(orderId: orderIdString, phone: phone, responseDict: responseDict!, onlinePaymentInitResponse: onlinePaymentInitResponse!)
                                        } else if paymentOption == .paytm {
                                            self?.dataModelDelegate?.initiatePayTMWebOnlinePayment(orderId: orderIdString, onlinePaymentInitResponse: onlinePaymentInitResponse!)
                                        } else if paymentOption == .simpl {
                                            self?.dataModelDelegate?.initiateSimplPayment(orderId: orderIdString, phone: phone, transactionId: onlinePaymentInitResponse!.transactionId)
                                        } else {
                                            if paymentOption == .prepaid {
                                                AnalyticsManager.shared.orderPlacedUsingWallet(amount: NSDecimalNumber(decimal: self!.itemsTotalPrice))
                                            }
                                            self?.orderPlacedTracking(orderId: orderIdString, phone: phone)
                                            self?.dataModelDelegate?.showOrderConfirmationAlert(orderId: orderIdString)
                                        }
            }, failure: { [weak self] (error) in
                AnalyticsManager.shared.orderPlacementFailure(amount: self!.itemsTotalPrice)
                self?.dataModelDelegate?.placingOrder(isProcessing: false)
                self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: error)
                
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
}

extension OrderPaymentDataModel {
    
    public func verifyTransaction(paymentId: String, phone: String, orderId: String, transactionId: String) {
        dataModelDelegate?.verifyingTransaction(isProcessing: true)
        orderPlacedTracking(orderId: orderId, phone: phone)

        let dataTask: URLSessionDataTask = APIManager.shared.verifyPayment(pid: paymentId,
                                                       orderId: orderId,
                                                       transactionId: transactionId,
                                                       completion: { [weak self] (responseDict) in
                                                        self?.dataModelDelegate?.verifyingTransaction(isProcessing: false)
                                                        if let status: String = responseDict?["status"] as? String, status == "3" {
                                                            self?.dataModelDelegate?.showOrderConfirmationAlert(orderId: orderId)
                                                        } else {
                                                            let apiError: UPAPIError? = UPAPIError(responseObject: responseDict)
                                                            self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: apiError)
                                                        }
            }, failure: { [weak self] (error) in
                self?.dataModelDelegate?.verifyingTransaction(isProcessing: false)
                self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: error)
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    

    public func orderPlacedTracking(orderId: String, phone: String) {
        AnalyticsManager.shared.orderPlaced(orderId: orderId, phone: phone, orderPaymentDataModel: self)
    }

}

extension OrderPaymentDataModel: AppUserDataModelDelegate {

    public func refreshBizInfoUI(isRefreshing: Bool, isFirstUpdate: Bool) {
        guard !isRefreshing else { return }
        bizInfo = AppUserDataModel.shared.bizInfo
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
