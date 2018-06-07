//
//  APIManager+User.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension APIManager {
    
    @objc public func userSavedAddresses(completion: APICompletion<UserAddressesResponse>?,
                         failure: APIFailure?) -> URLSessionTask {
        
        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        let urlString = "\(APIManager.baseUrl)/api/v1/user/address/?biz_id=\(appId)"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let userAddressesResponse = UserAddressesResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(userAddressesResponse)
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
    
    @objc public func addAddress(address: Address,
                                 completion: APICompletion<AddUpdateAddressResponse>?,
                                 failure: APIFailure?) -> URLSessionTask {
        
        let urlString = "\(APIManager.baseUrl)/api/v1/user/address/"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let addressDict = ["tag" : address.tag,
                           "biz_id" : AppConfigManager.shared.firRemoteConfigDefaults.bizAppId,
                           "sub_locality" : address.subLocality,
                           "address_1" : address.address1,
                           "address_2" : address.address2 ?? "",
                           "city" : address.city ?? "",
                           "pin" : address.pin ?? "",
                           "lat" : DeliveryLocationDataModel.shared.deliveryLocation?.coordinate.latitude ?? Double(0),
                           "lng" : DeliveryLocationDataModel.shared.deliveryLocation?.coordinate.longitude ?? Double(0)] as [String : Any]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: addressDict, options: [])
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let addUpdateAddressResponse = AddUpdateAddressResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(addUpdateAddressResponse)
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
    
    @objc public func updateAddress(address: Address,
                                    completion: APICompletion<AddUpdateAddressResponse>?,
                                    failure: APIFailure?) -> URLSessionTask {
        
        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!

        let urlString = "\(APIManager.baseUrl)/api/v1/user/address/"

        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let addressDict = ["tag": address.tag,
                           "id": address.id!,
                           "biz_id" : appId,
                           "sub_locality" : address.subLocality,
                           "address_1" : address.address1,
                           "address_2" : address.address2 ?? "",
                           "city" : address.city ?? "",
                           "pin" : address.pin ?? "",
                           "lat" : DeliveryLocationDataModel.shared.deliveryLocation?.coordinate.latitude ?? Double(0),
                           "lng" : DeliveryLocationDataModel.shared.deliveryLocation?.coordinate.longitude ?? Double(0)] as [String : Any]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: addressDict, options: [])
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let addUpdateAddressResponse = AddUpdateAddressResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(addUpdateAddressResponse)
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
    
    @objc public func deleteAddress(address: Address, completion: APISuccess?,
                                    failure: APIFailure?) -> URLSessionTask {
        
        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!

        let urlString = "\(APIManager.baseUrl)/api/v1/user/address/\(address.id!)/?biz_id=\(appId)"

        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "DELETE"
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                DispatchQueue.main.async {
                    completionClosure()
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
