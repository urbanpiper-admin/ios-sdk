//
//  APIManager+User.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension APIManager {
    
    @objc public func userInfo(phone: String,
                               completion: APICompletion<[String: Any]>?,
                               failure: APIFailure?) -> URLSessionTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/profile/?customer_phone=\(phone)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    
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
                    guard let apiError: UPAPIError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return dataTask
    }

    @objc public func updateUserInfo(name: String,
                                     phone: String,
                                     email: String,
                                     gender: String? = nil,
                                     anniversary: Date? = nil,
                                     birthday: Date? = nil,
                                     completion: APICompletion<[String: Any]>?,
                                     failure: APIFailure?) -> URLSessionTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/profile/?customer_phone=\(phone)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "PUT"
        
        let userInfo = ["email": email,
                        "phone": phone,
                        "gender": gender ?? "",
                        "anniversary": (anniversary?.timeIntervalSince1970 ?? 0) * 1000,
                        "birthday": (birthday?.timeIntervalSince1970 ?? 0) * 1000,
                        "first_name": name] as [String : Any]
        
        let params = ["user_data": userInfo]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    
                    if let success: Bool = dictionary["success"] as? Bool, success {
                        
                        DispatchQueue.main.async {
                            completionClosure(userInfo)
                        }
                        return
                    } else {
                        DispatchQueue.main.async {
                            let apiError: UPAPIError? = UPAPIError(responseObject: dictionary)!
                            failure?(apiError)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completionClosure(nil)
                    }
                } else {
                    if let failureClosure = failure {
                        guard let apiError: UPAPIError = UPAPIError(error: error, data: data) else { return }
                        DispatchQueue.main.async {
                            failureClosure(apiError as UPError)
                        }
                    }
                }
                
            }
        }
        
        return dataTask
    }
    
    @objc public func updatePassword(phone: String,
                                     oldPassword: String,
                                     newPassword: String,
                                     completion: APICompletion<[String: Any]>?,
                                     failure: APIFailure?) -> URLSessionTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/password/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "PUT"
        
        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        let params = ["user_data":["phone": phone,
                                   "biz_id": appId,
                                   "old_password": oldPassword,
                                   "new_password1": newPassword,
                                   "new_password2": newPassword]]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    
                    if let status: String = dictionary["status"] as? String, status.lowercased() == "success" {
                        DispatchQueue.main.async {
                            completionClosure(dictionary)
                        }
                        return
                    } else {
                        DispatchQueue.main.async {
                            let apiError: UPAPIError? = UPAPIError(responseObject: dictionary)!
                            failure?(apiError)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completionClosure(nil)
                    }
                } else {
                    if let failureClosure = failure {
                        guard let apiError: UPAPIError = UPAPIError(error: error, data: data) else { return }
                        DispatchQueue.main.async {
                            failureClosure(apiError as UPError)
                        }
                    }
                }
                
            }
        }
        
        return dataTask
    }
    
    @objc public func userSavedAddresses(completion: APICompletion<UserAddressesResponse>?,
                         failure: APIFailure?) -> URLSessionTask {
        
        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/?biz_id=\(appId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let userAddressesResponse: UserAddressesResponse = UserAddressesResponse(fromDictionary: dictionary)
                    
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
                    guard let apiError: UPAPIError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return dataTask
    }
    
    @objc public func addAddress(address: Address,
                                 completion: APICompletion<AddUpdateAddressResponse>?,
                                 failure: APIFailure?) -> URLSessionTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
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
        
        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let addUpdateAddressResponse: AddUpdateAddressResponse = AddUpdateAddressResponse(fromDictionary: dictionary)
                    
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
                    guard let apiError: UPAPIError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return dataTask
    }
    
    @objc public func updateAddress(address: Address,
                                    completion: APICompletion<AddUpdateAddressResponse>?,
                                    failure: APIFailure?) -> URLSessionTask {
        
        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!

        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/"

        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
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
        
        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let addUpdateAddressResponse: AddUpdateAddressResponse = AddUpdateAddressResponse(fromDictionary: dictionary)
                    
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
                    guard let apiError: UPAPIError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return dataTask
    }
    
    @objc public func deleteAddress(address: Address, completion: APISuccess?,
                                    failure: APIFailure?) -> URLSessionTask {
        
        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!

        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/\(address.id!)/?biz_id=\(appId)"

        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "DELETE"
        
        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                DispatchQueue.main.async {
                    completionClosure()
                }
            } else {
                if let failureClosure = failure {
                    guard let apiError: UPAPIError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return dataTask
    }
}
