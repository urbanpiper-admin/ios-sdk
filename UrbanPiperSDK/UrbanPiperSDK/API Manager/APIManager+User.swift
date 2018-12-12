//
//  APIManager+User.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {
    
    @objc public func userInfo(phone: String,
                               completion: (([String: Any]?) -> Void)?,
                               failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/profile/?customer_phone=\(phone)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
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
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
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
                                     completion: (([String: Any]?) -> Void)?,
                                     failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/profile/?customer_phone=\(phone)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "PUT"
        
        var userInfo: [String: Any] = ["email": email,
                        "phone": phone,
                        "first_name": name] as [String : Any]
        
        if let string = gender {
            userInfo["gender"] = string
        }
        
        if let date = birthday {
            userInfo["birthday"] = date.timeIntervalSince1970 * 1000
        }
        
        if let date = anniversary {
            userInfo["anniversary"] = date.timeIntervalSince1970 * 1000
        }
        
        let params: [String: Any] = ["user_data": userInfo]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
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
                    self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
                }
                
            }
        }
        
        return dataTask
    }
    
    @objc public func updatePassword(phone: String,
                                     oldPassword: String,
                                     newPassword: String,
                                     completion: (([String: Any]?) -> Void)?,
                                     failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/password/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "PUT"
        
        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!
        let params: [String: Any] = ["phone": phone,
                                   "biz_id": appId,
                                   "old_password": oldPassword,
                                   "new_password1": newPassword,
                                   "new_password2": newPassword]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
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
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
        }
        
        return dataTask
    }
    
    @objc public func userSavedAddresses(completion: ((UserAddressesResponse?) -> Void)?,
                         failure: APIFailure?) -> URLSessionDataTask {
        
        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/?biz_id=\(appId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
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
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    public func userSavedDeliverableAddresses(locationId: Int?,
                                                    completion: ((UserAddressesResponse?) -> Void)?,
                                                    failure: APIFailure?) -> URLSessionDataTask {
        
        var urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/"

        if let id = locationId {
            urlString = "\(urlString)?location_id=\(id)"
        } else {
            let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!
            urlString = "\(urlString)?biz_id=\(appId)"
        }
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
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
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    @objc public func addAddress(address: Address,
                                 completion: ((AddUpdateAddressResponse?) -> Void)?,
                                 failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        var addressDict: [String: Any] = ["tag" : address.tag,
                           "biz_id" : AppConfigManager.shared.firRemoteConfigDefaults.bizId,
                           "sub_locality" : address.subLocality,
                           "address_1" : address.address1,
                           "landmark" : "",
                           "city" : "",
                           "pin" : "",
                           "lat" : Double.zero,
                           "lng" : Double.zero]
        
        if let landmark = address.landmark {
            addressDict["landmark"] = landmark
        }
        
        if let city = address.city {
            addressDict["city"] = city
        }
        
        if let pin = address.pin {
            addressDict["pin"] = pin
        }
        
        if let lat = DeliveryLocationDataModel.shared.deliveryLocation?.coordinate.latitude {
            addressDict["lat"] = lat
        }
        
        if let lng = DeliveryLocationDataModel.shared.deliveryLocation?.coordinate.longitude {
            addressDict["lng"] = lng
        }
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: addressDict, options: [])
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
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
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    @objc public func updateAddress(address: Address,
                                    completion: ((AddUpdateAddressResponse?) -> Void)?,
                                    failure: APIFailure?) -> URLSessionDataTask {
        
        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!

        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/"

        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        

        var addressDict: [String: Any] = ["tag": address.tag,
                           "id": address.id!,
                           "biz_id" : appId,
                           "sub_locality" : address.subLocality,
                           "address_1" : address.address1,
                           "landmark" : "",
                           "city" : "",
                           "pin" : "",
                           "lat" : Double.zero,
                           "lng" : Double.zero]
        
        if let landmark = address.landmark {
            addressDict["landmark"] = landmark
        }
        
        if let city = address.city {
            addressDict["city"] = city
        }
        
        if let pin = address.pin {
            addressDict["pin"] = pin
        }
        
        if let lat = DeliveryLocationDataModel.shared.deliveryLocation?.coordinate.latitude {
            addressDict["lat"] = lat
        }
        
        if let lng = DeliveryLocationDataModel.shared.deliveryLocation?.coordinate.longitude {
            addressDict["lng"] = lng
        }
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: addressDict, options: [])
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
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
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    @objc public func deleteAddress(address: Address, completion: APISuccess?,
                                    failure: APIFailure?) -> URLSessionDataTask {
        
        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!

        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/\(address.id!)/?biz_id=\(appId)"

        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "DELETE"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
                guard let completionClosure = completion else { return }
                DispatchQueue.main.async {
                    completionClosure()
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
}
