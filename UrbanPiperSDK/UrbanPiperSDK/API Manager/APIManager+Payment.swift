//
//  APIManager+Payment.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

public enum OnlinePaymentPurpose: String {
    case reload = "reload"
    case ordering = "ordering"
}

extension APIManager {

    @objc public func preProcessOrder(bizLocationId: Int,
                               applyWalletCredit: Bool,
                               deliveryOption: String,
                               items: [ItemObject],
                               orderTotal: Decimal,
                               completion: APICompletion<OrderPreProcessingResponse>?,
                               failure: APIFailure?) -> URLSessionTask {
        
        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        let urlString = "\(APIManager.baseUrl)/api/v1/order/?format=json&pre_proc=1&biz_id=\(appId)"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let params = ["biz_location_id": bizLocationId,
                      "apply_wallet_credit": applyWalletCredit,
                      "order_type": deliveryOption,
                      "channel": APIManager.channel,
                      "items": items.map { $0.apiItemDictionary },
                      "order_total": orderTotal] as [String : Any]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let orderPreProcessingResponse = OrderPreProcessingResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(orderPreProcessingResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                if let failureClosure = failure {
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return task
    }

    @objc public func applyCoupon(code: String,
                           orderData: [String: Any],
                           completion: APICompletion<Order>?,
                           failure: APIFailure?) -> URLSessionTask {
        
        let urlString = "\(APIManager.baseUrl)/api/v1/coupons/\(code)/"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let params = ["order": orderData]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let applyCouponResponse = Order(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(applyCouponResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                if let failureClosure = failure {
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return task
    }
    
    @objc public func initiateOnlinePayment(paymentOption: String,
                                     purpose: String,
                                     totalAmount: Decimal,
                                     bizLocationId: Int,
                                     completion: APICompletion<OnlinePaymentInitResponse>?,
                                     failure: APIFailure?) -> URLSessionTask {
        
        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        
        var urlString = ""
        
        if paymentOption == PaymentOption.paytm.rawValue {
            urlString = "\(APIManager.baseUrl)/payments/init/\(appId)/?amount=\(totalAmount * 100)&purpose=\(purpose)&channel=\(APIManager.channel)&redirect_url=https://urbanpiper.com&paytm=1"
        } else {
            urlString = "\(APIManager.baseUrl)/payments/init/\(appId)/\(bizLocationId)/?amount=\(totalAmount * 100)&purpose=\(purpose)&channel=\(APIManager.channel)&\(paymentOption)=1"
        }
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let onlinePaymentInitResponse = OnlinePaymentInitResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(onlinePaymentInitResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                if let failureClosure = failure {
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return task
    }
    
    @objc public func placeOrder(address: Address?,
                          items: [ItemObject],
                          deliveryDate: Date,
                          timeSlot: TimeSlot?,
                          deliveryOption: String,
                          instructions: String = "",
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
                          completion: APICompletion<[String: Any]>?,
                          failure: APIFailure?) -> URLSessionTask {
        
        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        let urlString = "\(APIManager.baseUrl)/api/v1/order/?format=json&biz_id=\(appId)"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        var params = ["channel": APIManager.channel,
                      "order_type": deliveryOption,
                      "instructions": instructions,
                      "items": items.map { $0.apiItemDictionary },
                      "payment_option": paymentOption,
                      "phone": phone,
                      "biz_location_id": bizLocationId,
                      "delivery_datetime": deliveryDate.timeIntervalSince1970 * 1000,
                      "order_subtotal": orderSubTotal,
                      "tax_rate": taxRate,
                      "packaging_charge": packagingCharge,
                      "item_taxes": itemTaxes,
                      "discount_applied": discountApplied,
                      "delivery_charge": deliveryOption == DeliveryOption.pickUp.rawValue ? Decimal(0).rounded : deliveryCharge,
                      "order_total": orderTotal] as [String: Any]
        
        if applyWalletCredit {
            params["wallet_credit_applicable"] = true
            params["wallet_credit_applied"] = walletCreditApplied
            params["payable_amount"] = payableAmount
        }
        
        if let code = couponCode {
            params["coupon"] = code
        }
        
        if let addressObject = address, deliveryOption != DeliveryOption.pickUp.rawValue {
            params["address_id"] = addressObject.id
            params["address_lat"] = addressObject.lat ?? 0
            params["address_lng"] = addressObject.lng ?? 0
        }
        
        if let timeSlotObject = timeSlot, AppConfigManager.shared.firRemoteConfigDefaults.enableTimeSlots {
            params["time_slot_end"] = timeSlotObject.endTime
            params["time_slot_start"] = timeSlotObject.startTime
        }
        
        if let trxId = onlinePaymentInitResponse?.transactionId {
            params["payment_server_trx_id"] = trxId
            params["state"] = "awaiting_payment"
        }
                
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    DispatchQueue.main.async {
                        completionClosure(dictionary)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                if let failureClosure = failure {
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return task
    }
    
    @objc public func verifyPayment(pid: String,
                             orderId: String,
                             transactionId: String,
        completion: APICompletion<[String: Any]>?,
                           failure: APIFailure?) -> URLSessionTask {
        
        let urlString = "\(APIManager.baseUrl)/payments/callback/\(transactionId)/?gateway_txn_id=\(pid)&pid=\(orderId)"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    DispatchQueue.main.async {
                        completionClosure(dictionary)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                if let failureClosure = failure {
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return task
    }
}
