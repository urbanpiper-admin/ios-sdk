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
                let currencyPrefix = AppConfigManager.shared.firRemoteConfigDefaults.lblCurrencySymbol!
                return "DELIVERY (MIN ORDER \(currencyPrefix) \(amount))"
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
    
    @objc optional func refreshCouponUI(_ isRefreshing: Bool)
    
    func initiatingPayment(isProcessing: Bool)
    
    func placingOrder(isProcessing: Bool)
    
    func verifyingTransaction(isProcessing: Bool)

    func initiatePayTMWebOnlinePayment(orderId: String, onlinePaymentInitResponse: OnlinePaymentInitResponse)
    
    func initiateRazorOnlinePayment(orderId: String, phone: String, responseDict: [String: Any], onlinePaymentInitResponse: OnlinePaymentInitResponse)
    
    func initiateSimplPayment(orderId: String, phone: String, transactionId: String)
    
    func showOrderConfirmationAlert(orderId: String)
    
    func handleOrderPayment(error: UPError?)
}

public class OrderPaymentDataModel: UrbanPiperDataModel {
        
    public var orderPreProcessingResponse: OrderPreProcessingResponse? {
        didSet {
            guard orderPreProcessingResponse != nil else { return }
            applyWalletCredits = orderPreProcessingResponse?.order.walletCreditApplicable ?? false
            
            if oldValue == nil {
                selectedPaymentOption = defaultPaymentOption
            }
            
            if applyCouponResponse != nil && couponCode != nil {
                let code = couponCode!
                DispatchQueue.main.async { [weak self] in
                    self?.applyCoupon(code: code)
                }
            }
            couponCode = nil
            applyCouponResponse = nil
        }
    }
    
    public var bizInfo: BizInfo? {
        didSet {
            guard oldValue == nil && bizInfo != nil else { return }
            selectedDeliveryOption = defaultDeliveryOption
        }
    }
    
    public var deliveryAddress: Address? {
        guard let defaultAddressData = UserDefaults.standard.object(forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey) as? Data else { return nil }
            Address.registerClassName()
        guard let address = NSKeyedUnarchiver.unarchiveObject(with: defaultAddressData) as? Address else { return nil }
        return address
    }

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
        return orderResponse?.deliveryCharge ?? OrderingStoreDataModel.shared.nearestStoreResponse?.store?.deliveryCharge ?? Decimal(0).rounded
    }
    
    public var packagingCharge: Decimal? {
        return orderResponse?.packagingCharge ?? OrderingStoreDataModel.shared.nearestStoreResponse?.store?.packagingCharge
    }
    
    public var discountPrice: Decimal? {
        return applyCouponResponse?.discount.value ?? orderPreProcessingResponse?.discount ?? OrderingStoreDataModel.shared.nearestStoreResponse?.store?.discount
    }

    public var itemsTotalPrice: Decimal {
        return orderResponse?.payableAmount ?? CartManager.shared.cartValue
    }
    
    public var itemTaxes: Decimal? {
        return orderResponse?.itemTaxes ?? OrderingStoreDataModel.shared.nearestStoreResponse?.store?.itemTaxes
    }
    
    public var taxRate: Float {
        return orderResponse?.taxRate ?? OrderingStoreDataModel.shared.nearestStoreResponse?.store?.taxRate ?? 0
    }

    lazy public var selectedPaymentOption: PaymentOption = {
        return defaultPaymentOption
    }()
    
    private var defaultPaymentOption: PaymentOption {
        if let option = AppConfigManager.shared.firRemoteConfigDefaults.forcePaymentOptSel, option {
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
        if let deliveryOption = deliveryOptions?.first {
            return deliveryOption
        }
        return .delivery
    }
    
    lazy public var selectedDeliveryTimeSlotOption: TimeSlot? = {
        guard let deliveryTimeSlotOption = deliverySlotsOptions?.first else { return nil }
            return deliveryTimeSlotOption
    }()
    
    lazy public var selectedRequestedTime: Date = defaultOrderDeliveryDateTime
    
    lazy public var selectedRequestedDate: Date = defaultOrderDeliveryDateTime
    
    public var deliveryDate: Date {
        var units: Set<Calendar.Component> = [.day, .month, .year]
        var comps = Calendar.current.dateComponents(units, from: selectedRequestedDate)
        let day = Calendar.current.date(from: comps)
        
        units = [.hour, .minute, .second]
        comps = Calendar.current.dateComponents(units, from: selectedRequestedTime)
        
        return Calendar.current.date(byAdding: comps, to: day!)!
    }
    
    public var normalDefaultOrderDeliveryDate: Date {
        let delMinOffset = TimeInterval(Biz.shared!.deliveryMinOffsetTime)
        let defaultOffset = TimeInterval(100000.0)
        // around 2 minutes gap to payment
        let normalDeliveryDate = Date().addingTimeInterval(((delMinOffset + defaultOffset) / 1000.0))
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
        
        var paymentArray = paymentsStringArray.compactMap { PaymentOption(rawValue: $0) }
        
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

        if let paymentOptionString = AppConfigManager.shared.firRemoteConfigDefaults.dfltPymntOpt,
            let option = PaymentOption(rawValue: paymentOptionString) {
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
        
    public func refreshData(_ isForcedRefresh: Bool = false) {
        guard AppUserDataModel.shared.validAppUserData != nil else { return }

        if isForcedRefresh || bizInfo == nil {
            bizInfo = nil
            updateUserBizInfo()
        }

        if isForcedRefresh || orderPreProcessingResponse == nil
            || (selectedDeliveryOption == .pickUp && deliveryCharge > Decimal(0).rounded)
            || (selectedDeliveryOption != .pickUp && deliveryCharge == Decimal(0).rounded) {
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
                
        let dataTask = APIManager.shared.preProcessOrder(bizLocationId: OrderingStoreDataModel.shared.nearestStoreResponse!.store!.bizLocationId,
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
                self?.dataModelDelegate?.handleOrderPayment(error: upError)
            }
        })
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    fileprivate func updateUserBizInfo() {
        dataModelDelegate?.refreshWalletUI(true)
        let dataTask = APIManager.shared.fetchBizInfo(completion: { [weak self] (info) in
            defer {
                self?.dataModelDelegate?.refreshWalletUI(false)
            }
            self?.bizInfo = info
        }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.refreshWalletUI(false)
                self?.dataModelDelegate?.handleOrderPayment(error: upError)
            }
        })
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func applyCoupon(code: String) {
        guard code.count > 0 else { return }
        let orderDict = ["biz_location_id": OrderingStoreDataModel.shared.nearestStoreResponse!.store!.bizLocationId,
                         "order_type": selectedDeliveryOption.rawValue,
                         "channel": APIManager.channel,
                         "items": CartManager.shared.cartItems.map { $0.discountCouponApiItemDictionary },
                         "apply_wallet_credit": applyWalletCredits] as [String : Any]
        
        dataModelDelegate?.refreshCouponUI?(true)
        let dataTask = APIManager.shared.applyCoupon(code: code,
                                                     orderData: orderDict,
                                                     completion: { [weak self] (applyCouponResponse) in
            defer {
                self?.couponCode = code
                self?.dataModelDelegate?.refreshCouponUI?(false)
            }
            self?.applyCouponResponse = applyCouponResponse
            }, failure: { [weak self] (upError) in
                defer {
                    self?.dataModelDelegate?.refreshCouponUI?(false)
                    self?.dataModelDelegate?.handleOrderPayment(error: upError)
                }
        })
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func payOnlineAndPlaceOrder(instructions: String,
                                phone: String) {
        dataModelDelegate?.initiatingPayment(isProcessing: true)
        let paymentOption = selectedPaymentOption
        let dataTask = APIManager.shared.initiateOnlinePayment(paymentOption: paymentOption,
                                                               purpose: OnlinePaymentPurpose.ordering,
                                                               totalAmount: itemsTotalPrice,
                                                               bizLocationId: OrderingStoreDataModel.shared.nearestStoreResponse!.store!.bizLocationId,
                                                               completion: { [weak self] (onlinePaymentInitResponse) in
                                                                self?.dataModelDelegate?.initiatingPayment(isProcessing: false)
                                                                if paymentOption == .paymentGateway || paymentOption == .paytm || paymentOption == .simpl {
                                                                    self?.placeOrder(instructions: instructions, phone: phone, onlinePaymentInitResponse: onlinePaymentInitResponse)
                                                                }
        }, failure: { [weak self] (error) in
            self?.dataModelDelegate?.initiatingPayment(isProcessing: false)
            self?.dataModelDelegate?.handleOrderPayment(error: error)
        })

        guard let task = dataTask else { return }
        addOrCancelDataTask(dataTask: task)
    }
        
    public func placeOrder(instructions: String,
                    phone: String,
                    onlinePaymentInitResponse: OnlinePaymentInitResponse? = nil) {
        
        dataModelDelegate?.placingOrder(isProcessing: true)
        
        let timeSlotDelivery = AppConfigManager.shared.firRemoteConfigDefaults.enableTimeSlots!
        
        let paymentOption = selectedPaymentOption
        let dataTask = APIManager.shared.placeOrder(address: selectedDeliveryOption != .pickUp ? deliveryAddress : nil,
                                     items: CartManager.shared.cartItems,
                                     deliveryDate: deliveryDate,
                                     timeSlot: timeSlotDelivery ? selectedDeliveryTimeSlotOption : nil,
                                     deliveryOption: selectedDeliveryOption.rawValue,
                                     phone: phone,
                                     bizLocationId: OrderingStoreDataModel.shared.nearestStoreResponse!.store!.bizLocationId,
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
                                     walletCreditApplied: orderPreProcessingResponse?.order.walletCreditApplied ?? Decimal(0).rounded,
                                     payableAmount: itemsTotalPrice,
                                     onlinePaymentInitResponse: onlinePaymentInitResponse,
                                     completion: { [weak self] (responseDict) in
                                        self?.dataModelDelegate?.placingOrder(isProcessing: false)
                                        guard let orderId = responseDict?["order_id"] else {
                                            let error = UPAPIError(responseObject: responseDict)
                                            self?.dataModelDelegate?.handleOrderPayment(error: error)
                                            return
                                        }
                                        let orderIdString = "\(orderId)"
                                        
                                        guard orderIdString.count > 0 else {
                                            let error = UPAPIError(responseObject: responseDict)
                                            self?.dataModelDelegate?.handleOrderPayment(error: error)
                                            return
                                        }

                                        if paymentOption == .paymentGateway {
                                            self?.dataModelDelegate?.initiateRazorOnlinePayment(orderId: orderIdString, phone: phone, responseDict: responseDict!, onlinePaymentInitResponse: onlinePaymentInitResponse!)
                                        } else if paymentOption == .paytm {
                                            self?.dataModelDelegate?.initiatePayTMWebOnlinePayment(orderId: orderIdString, onlinePaymentInitResponse: onlinePaymentInitResponse!)
                                        } else if paymentOption == .simpl {
                                            self?.dataModelDelegate?.initiateSimplPayment(orderId: orderIdString, phone: phone, transactionId: onlinePaymentInitResponse!.transactionId)
                                        } else {
                                            self?.orderPlacedTracking(orderId: orderIdString, phone: phone)
                                            self?.dataModelDelegate?.showOrderConfirmationAlert(orderId: orderIdString)
                                        }
            }, failure: { [weak self] (error) in
                AnalyticsManager.shared.orderPlacementFailure(amount: self!.itemsTotalPrice)
                self?.dataModelDelegate?.placingOrder(isProcessing: false)
                self?.dataModelDelegate?.handleOrderPayment(error: error)
                
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
}

extension OrderPaymentDataModel {
    
    public func verifyTransaction(paymentId: String, phone: String, orderId: String, transactionId: String) {
        dataModelDelegate?.verifyingTransaction(isProcessing: true)
        orderPlacedTracking(orderId: orderId, phone: phone)

        let dataTask = APIManager.shared.verifyPayment(pid: paymentId,
                                                       orderId: orderId,
                                                       transactionId: transactionId,
                                                       completion: { [weak self] (responseDict) in
                                                        self?.dataModelDelegate?.verifyingTransaction(isProcessing: false)
                                                        if let status = responseDict?["status"] as? String, status == "3" {
                                                            self?.dataModelDelegate?.showOrderConfirmationAlert(orderId: orderId)
                                                        } else {
                                                            let upError = UPAPIError(responseObject: responseDict)
                                                            self?.dataModelDelegate?.handleOrderPayment(error: upError)
                                                        }
            }, failure: { [weak self] (error) in
                self?.dataModelDelegate?.verifyingTransaction(isProcessing: false)
                self?.dataModelDelegate?.handleOrderPayment(error: error)
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    

    public func orderPlacedTracking(orderId: String, phone: String) {
        AnalyticsManager.shared.orderPlaced(orderId: orderId, phone: phone, orderPaymentDataModel: self)
    }

}

extension OrderPaymentDataModel: AppUserDataModelDelegate {

    public func refreshAppUserUI(isRefreshing: Bool) {

    }

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
