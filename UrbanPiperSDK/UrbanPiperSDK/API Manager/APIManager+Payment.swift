//
//  APIManager+Payment.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

public enum OnlinePaymentPurpose: String {
    case reload = "reload"
    case ordering = "ordering"
}

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
    
    public var deliveryOptionOffsetTimeSecs: TimeInterval {
        switch self {
        case .delivery:
            return TimeInterval((OrderingStoreDataModel.shared.orderingStore?.deliveryMinOffsetTime ?? Biz.shared!.deliveryMinOffsetTime) / 1000)
        case .pickUp:
            return TimeInterval((OrderingStoreDataModel.shared.orderingStore?.pickupMinOffsetTime ?? Biz.shared!.pickupMinOffsetTime) / 1000)
        }
    }
}

extension APIManager {

    @objc public func preProcessOrder(bizLocationId: Int,
                               applyWalletCredit: Bool,
                               deliveryOption: String,
                               items: [ItemObject],
                               orderTotal: Decimal,
                               completion: ((OrderPreProcessingResponse?) -> Void)?,
                               failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/order/?format=json&pre_proc=1&biz_id=\(bizId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let params: [String: Any] = ["biz_location_id": bizLocationId,
                      "apply_wallet_credit": applyWalletCredit,
                      "order_type": deliveryOption,
                      "channel": APIManager.channel,
                      "items": items.map { $0.apiItemDictionary },
                      "order_total": orderTotal] as [String : Any]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let orderPreProcessingResponse: OrderPreProcessingResponse = OrderPreProcessingResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(orderPreProcessingResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }

    @objc public func applyCoupon(code: String,
                           orderData: [String: Any],
                           completion: ((Order?) -> Void)?,
                           failure: APIFailure?) -> URLSessionDataTask {
        
        var urlString: String = "\(APIManager.baseUrl)/api/v1/coupons/\(code)/"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let params: [String: Any] = ["order": orderData]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let applyCouponResponse: Order = Order(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(applyCouponResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    public func initiateOnlinePayment(paymentOption: PaymentOption,
                                      purpose: OnlinePaymentPurpose,
                                      totalAmount: Decimal,
                                      bizLocationId: Int?,
                                      completion: ((OnlinePaymentInitResponse?) -> Void)?,
                                      failure: APIFailure?) -> URLSessionDataTask? {
        
        
        var urlString: String = "\(APIManager.baseUrl)/payments/init/\(bizId)/"

        if purpose == OnlinePaymentPurpose.ordering {
            guard let locationId = bizLocationId else { return nil}
            urlString = urlString + "\(locationId)/"
        }
        
        if paymentOption == PaymentOption.paytm {
            urlString = "\(urlString)?amount=\(totalAmount * 100)&purpose=\(purpose)&channel=\(APIManager.channel)&redirect_url=https://urbanpiper.com/pg-redirect&paytm=1"
        } else if paymentOption == PaymentOption.paymentGateway {
            urlString = "\(urlString)?amount=\(totalAmount * 100)&purpose=\(purpose)&channel=\(APIManager.channel)&\(paymentOption.rawValue)=1&redirect_url=https://urbanpiper.com/pg-redirect"
        } else {
            urlString = "\(urlString)?amount=\(totalAmount * 100)&purpose=\(purpose)&channel=\(APIManager.channel)&\(paymentOption.rawValue)=1"
        }
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let onlinePaymentInitResponse: OnlinePaymentInitResponse = OnlinePaymentInitResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(onlinePaymentInitResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    public func placeOrder(address: Address?,
                           items: [ItemObject],
                           deliveryDate: Date,
                           timeSlot: TimeSlot?,
                           deliveryOption: DeliveryOption,
                           instructions: String,
                           phone: String,
                           bizLocationId: Int,
                           paymentOption: String,
                           taxRate: Float,
                           couponCode: String?,
                           deliveryCharge: Decimal,
                           discountApplied: Decimal,
                           itemTaxes: Decimal,
                           packagingCharge: Decimal,
                           orderSubTotal: Decimal,
                           orderTotal: Decimal,
                           applyWalletCredit: Bool,
                           walletCreditApplied: Decimal,
                           payableAmount: Decimal,
                           onlinePaymentInitResponse: OnlinePaymentInitResponse?,
                           completion: (([String: Any]?) -> Void)?,
                           failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/order/?format=json&biz_id=\(bizId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let itemWithInstructionsArray = items.filter { $0.notes != nil && $0.notes!.count > 0 }
        var instructionsText: String
        
        if itemWithInstructionsArray.count > 0 {
            let itemsInstructionsStringArray = itemWithInstructionsArray.map { "\($0.itemTitle!) : \($0.notes!)" }
            instructionsText = "\(itemsInstructionsStringArray.joined(separator: ",\n"))\n general instructions: \(instructions))"
            if instructions.count > 0 {
                instructionsText = "\(instructionsText)\n general instructions: \(instructions))"
            }
        } else {
            instructionsText = instructions
        }
        
        print("deliveryDate.timeIntervalSince1970 * 1000 \(deliveryDate.timeIntervalSince1970)")
        
        var params: [String: Any] = ["channel": APIManager.channel,
                      "order_type": deliveryOption.rawValue,
                      "instructions": instructionsText,
                      "items": items.map { $0.apiItemDictionary },
                      "payment_option": paymentOption,
                      "phone": phone,
                      "biz_location_id": bizLocationId,
                      "delivery_datetime": Int(deliveryDate.timeIntervalSince1970 * 1000),
                      "order_subtotal": orderSubTotal,
                      "tax_rate": taxRate,
                      "packaging_charge": packagingCharge,
                      "item_taxes": itemTaxes,
                      "discount_applied": discountApplied,
                      "delivery_charge": deliveryOption == DeliveryOption.pickUp ? Decimal.zero : deliveryCharge,
        "order_total": orderTotal] as [String: Any]
        
        print("params \(params as AnyObject)")
        
        if applyWalletCredit {
            params["wallet_credit_applicable"] = true
            params["wallet_credit_applied"] = walletCreditApplied
            params["payable_amount"] = payableAmount
        }
        
        if let code = couponCode {
            params["coupon"] = code
        }
        
        if let addressObject = address, deliveryOption != DeliveryOption.pickUp {
            params["address_id"] = addressObject.id
            params["address_lat"] = addressObject.lat
            params["address_lng"] = addressObject.lng
        }
        
        if let timeSlotObject = timeSlot {
            params["time_slot_end"] = timeSlotObject.endTime
            params["time_slot_start"] = timeSlotObject.startTime
        }
        
        if let trxId = onlinePaymentInitResponse?.transactionId {
            params["payment_server_trx_id"] = trxId
            params["state"] = "awaiting_payment"
        }
                
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    DispatchQueue.main.async {
                        completion?(dictionary)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    @objc public func verifyPayment(pid: String,
                             orderId: String,
                             transactionId: String,
        completion: (([String: Any]?) -> Void)?,
                           failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/payments/callback/\(transactionId)/?gateway_txn_id=\(pid)&pid=\(orderId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    DispatchQueue.main.async {
                        completion?(dictionary)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
}
