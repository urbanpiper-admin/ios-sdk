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

    func initiatePayTMWebOnlinePayment(orderId: String, onlinePaymentInitResponse: OnlinePaymentInitResponse)
    
    func initiateRazorOnlinePayment(orderId: String, phone: String, responseDict: OrderResponse?, onlinePaymentInitResponse: OnlinePaymentInitResponse)
    
    func initiatePaytabsOnlinePayment(orderId: String, phone: String, responseDict: OrderResponse?, onlinePaymentInitResponse: OnlinePaymentInitResponse)
    
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
            
            if selectedPaymentOption == .select, selectedPaymentOption != defaultPaymentOption {
                selectedPaymentOption = defaultPaymentOption
            }
            
            if applyCouponResponse != nil && couponCode != nil {
                let code = couponCode!
                let isSuggested = isSuggestedCoupon
                DispatchQueue.main.async { [weak self] in
                    self?.applyCoupon(code: code, isSuggested: isSuggested, preSelected: code == CartManager.shared.couponCodeToApply)
                    self?.couponCode = nil
                    self?.applyCouponResponse = nil
                }
            } else {
                couponCode = nil
                applyCouponResponse = nil
            }
        }
    }
    
    public var bizInfo: UserBizInfoResponse? {
        didSet {
            guard oldValue == nil && bizInfo != nil else { return }
            selectedDeliveryOption = defaultDeliveryOption
        }
    }
    
    public var deliveryAddress: Address?
//    {
//        guard let defaultAddressData: Data = UserDefaults.standard.object(forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey) as? Data else { return nil }
//            Address.registerClass()
//        guard let address: Address = NSKeyedUnarchiver.unarchiveObject(with: defaultAddressData) as? Address else { return nil }
//        return address
//    }

    public var couponCode: String?
    public var isSuggestedCoupon: Bool = false
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
        return applyCouponResponse?.discount.value ?? orderPreProcessingResponse?.order.discount?.value ?? OrderingStoreDataModel.shared.orderingStore?.discount
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
    
    public func refreshData(_ isForcedRefresh: Bool = false) {
        guard UserManager.shared.currentUser != nil else { return }

        if isForcedRefresh || bizInfo == nil {
            bizInfo = nil
            updateUserBizInfo()
        }

        if isForcedRefresh || orderPreProcessingResponse == nil || (selectedDeliveryOption == .pickUp && deliveryCharge > Decimal.zero) {
            orderPreProcessingResponse = nil
            preProcessOrder()
        }

    }

    public override init() {
        super.init()

        refreshData()
        UserManager.shared.addObserver(delegate: self)
    }

}

//  MARK: API Calls

extension OrderPaymentDataModel {
    
    public func preProcessOrder() {
        dataModelDelegate?.refreshPreProcessingUI(true)
                
        let dataTask: URLSessionDataTask = APIManager.shared.preProcessOrder(bizLocationId: OrderingStoreDataModel.shared.orderingStore!.bizLocationId,
                                                         applyWalletCredit: applyWalletCredits,
                                                         deliveryOption: selectedDeliveryOption.rawValue,
                                                         cartItems: CartManager.shared.cartItems,
                                                         orderTotal: itemsTotalPrice,
                                                         completion:
            { [weak self] (orderPreProcessingResponse) in
                defer {
                    self?.dataModelDelegate?.refreshPreProcessingUI(false)
                }
                if let order = orderPreProcessingResponse?.order, self?.orderPreProcessingResponse == nil {
                    AnalyticsManager.shared.track(event: .checkoutInit(payableAmt: order.payableAmount, walletCreditsApplied: order.walletCreditApplicable ?? false))
                }
                self?.orderPreProcessingResponse = orderPreProcessingResponse
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
        let orderDict: [String: Any] = ["biz_location_id": OrderingStoreDataModel.shared.orderingStore!.bizLocationId,
                         "order_type": selectedDeliveryOption.rawValue,
                         "channel": APIManager.channel,
                         "items": CartManager.shared.cartItems.map { $0.toDictionary() },
                         "apply_wallet_credit": applyWalletCredits] as [String: Any]
        
        dataModelDelegate?.refreshApplyCouponUI(true, code: code)
        let dataTask: URLSessionDataTask = APIManager.shared.applyCoupon(code: code,
                                                     orderData: orderDict,
                                                     completion:
            { [weak self] (applyCouponResponse) in
                if let discount = applyCouponResponse?.discount, discount.success {
//                    if let globalCoupon = CartManager.shared.couponCodeToApply, globalCoupon == code {
//                        self?.globalCouponApplied = true
//                    } else {
//                        self?.globalCouponApplied = false
//                    }


                    self?.applyCouponResponse = applyCouponResponse
                    self?.couponCode = code
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

        addDataTask(dataTask: dataTask)
    }
        
    public func placeOrder(instructions: String,
                    phone: String,
                    onlinePaymentInitResponse: OnlinePaymentInitResponse? = nil) {
        
        dataModelDelegate?.placingOrder(isProcessing: true)
        
        let timeSlotDelivery: Bool = AppConfigManager.shared.firRemoteConfigDefaults.enableTimeSlots
        
        let paymentOption = selectedPaymentOption
        let dataTask: URLSessionDataTask = APIManager.shared.placeOrder(address: selectedDeliveryOption != .pickUp ? deliveryAddress : nil,
                                     cartItems: CartManager.shared.cartItems,
                                     deliveryDate: deliveryDateTime!,
                                     timeSlot: timeSlotDelivery ? selectedDeliveryTimeSlotOption : nil,
                                     deliveryOption: selectedDeliveryOption,
                                     instructions: instructions,
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
                                     completion: { [weak self] (response) in
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
                                                self?.dataModelDelegate?.initiateRazorOnlinePayment(orderId: orderId, phone: phone, responseDict: response, onlinePaymentInitResponse: onlinePaymentInitResponse!)
                                            case .paytabs:
                                                self?.dataModelDelegate?.initiatePaytabsOnlinePayment(orderId: orderId, phone: phone, responseDict: response, onlinePaymentInitResponse: onlinePaymentInitResponse!)
                                            }
                                        } else if paymentOption == .paytm {
                                            self?.dataModelDelegate?.initiatePayTMWebOnlinePayment(orderId: orderId, onlinePaymentInitResponse: onlinePaymentInitResponse!)
                                        } else if paymentOption == .simpl {
                                            self?.dataModelDelegate?.initiateSimplPayment(orderId: orderId, phone: phone, transactionId: onlinePaymentInitResponse!.transactionId)
                                        } else {
                                            self?.orderPlacedTracking(orderId: orderId, phone: phone)
                                            self?.dataModelDelegate?.showOrderConfirmationAlert(orderId: orderId)
                                        }
            }, failure: { [weak self] (error) in
                self?.dataModelDelegate?.placingOrder(isProcessing: false)
                self?.dataModelDelegate?.handleOrderPayment(isOrderPaymentError: false, error: error)
        })
        
        addDataTask(dataTask: dataTask)
    }
    
}

extension OrderPaymentDataModel {
    
    public func verifyTransaction(paymentId: String, phone: String, orderId: String, transactionId: String) {
        dataModelDelegate?.verifyingTransaction(isProcessing: true)
        orderPlacedTracking(orderId: orderId, phone: phone)

        let dataTask: URLSessionDataTask = APIManager.shared.verifyPayment(pid: paymentId,
                                                       orderId: orderId,
                                                       transactionId: transactionId,
                                                       completion: { [weak self] (response) in
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
        AnalyticsManager.shared.track(event: .purchaseCompleted(orderID: orderId,
                                                                orderPaymentDataModel: self,
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
