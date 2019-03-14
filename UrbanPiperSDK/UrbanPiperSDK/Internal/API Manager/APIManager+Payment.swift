//
//  APIManager+Payment.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {

    internal func preProcessOrder(storeId: Int,
                               applyWalletCredit: Bool,
                               deliveryOption: DeliveryOption,
                               cartItems: [CartItem],
                               orderTotal: Decimal,
                               completion: ((PreProcessOrderResponse?) -> Void)?,
                               failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/order/?format=json&pre_proc=1&biz_id=\(bizId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let params: [String: Any] = ["biz_location_id": storeId,
                      "apply_wallet_credit": applyWalletCredit,
                      "order_type": deliveryOption.rawValue,
                      "channel": APIManager.channel,
                      "items": cartItems.map { $0.toDictionary() },
                      "order_total": orderTotal] as [String: Any]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> PreProcessOrderResponse? in
            return PreProcessOrderResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let preProcessOrderResponse: PreProcessOrderResponse = PreProcessOrderResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(preProcessOrderResponse)
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
        
        return dataTask*/
    }

//    @objc internal func applyCoupon(code: String,
//                           orderData: [String: Any],
//                           completion: ((Order?) -> Void)?,
//                           failure: APIFailure?) -> URLSessionDataTask {
//        
//        var urlString: String = "\(APIManager.baseUrl)/api/v1/coupons/\(code)/"
//        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        
//        let url: URL = URL(string: urlString)!
//        
//        var urlRequest: URLRequest = URLRequest(url: url)
//        
//        urlRequest.httpMethod = "POST"
//        
//        let params: [String: Any] = ["order": orderData]
//        
//        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
//        
//        
//        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> Order? in
//            return Order(fromDictionary: dictionary)
//        }, completion: completion, failure: failure)!
//        
//        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
//            
//            let statusCode = (response as? HTTPURLResponse)?.statusCode
//            if let code = statusCode, code == 200 {
//                
//                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
//                    let applyCouponResponse: Order = Order(fromDictionary: dictionary)
//                    
//                    DispatchQueue.main.async {
//                        completion?(applyCouponResponse)
//                    }
//                    return
//                }
//                
//                DispatchQueue.main.async {
//                    completion?(nil)
//                }
//            } else {
//                let errorCode = (error as NSError?)?.code
//                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
//            }
//            
//        }
//        
//        return dataTask*/
//    }
    
    internal func initiateOnlinePayment(paymentOption: PaymentOption,
                                      purpose: OnlinePaymentPurpose,
                                      totalAmount: Decimal,
                                      storeId: Int?,
                                      completion: ((PaymentInitResponse?) -> Void)?,
                                      failure: APIFailure?) -> URLSessionDataTask? {
        
        
        var urlString: String = "\(APIManager.baseUrl)/payments/init/\(bizId)/"

        if purpose == OnlinePaymentPurpose.ordering {
            guard let locationId = storeId else { return nil}
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
        
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> PaymentInitResponse? in
            return PaymentInitResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let paymentInitResponse: PaymentInitResponse = PaymentInitResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(paymentInitResponse)
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
        
        return dataTask*/
    }
    
    internal func placeOrder(address: Address?,
                           cartItems: [CartItem],
                           deliveryDate: Date,
                           timeSlot: TimeSlot?,
                           deliveryOption: DeliveryOption,
                           instructions: String,
                           phone: String,
                           storeId: Int,
                           paymentOption: PaymentOption,
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
                           paymentInitResponse: PaymentInitResponse?,
                           completion: ((OrderResponse?) -> Void)?,
                           failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/order/?format=json&biz_id=\(bizId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let itemWithInstructionsArray = cartItems.filter { $0.notes != nil && $0.notes!.count > 0 }
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
                      "items": cartItems.map { $0.toDictionary() },
                      "payment_option": paymentOption.rawValue,
                      "phone": phone,
                      "biz_location_id": storeId,
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
        
        if let trxId = paymentInitResponse?.transactionId {
            params["payment_server_trx_id"] = trxId
            params["state"] = "awaiting_payment"
        }
                
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> OrderResponse? in
            return OrderResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
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
        
        return dataTask*/
    }
    
    @objc internal func verifyPayment(pid: String,
                             orderId: String,
                             transactionId: String,
        completion: ((OrderVerifyTxnResponse?) -> Void)?,
                           failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/payments/callback/\(transactionId)/?gateway_txn_id=\(pid)&pid=\(orderId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> OrderVerifyTxnResponse? in
            return OrderVerifyTxnResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
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
        
        return dataTask*/
    }
}
