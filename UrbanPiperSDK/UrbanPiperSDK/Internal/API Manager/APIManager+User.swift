//
//  APIManager+User.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {
    
    @objc internal func refreshUserData(phone: String,
                                      completion: ((UserInfoResponse?) -> Void)?,
                                      failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/profile/?customer_phone=\(phone)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> UserInfoResponse? in
            print("refreshUserDataResponse \(dictionary as AnyObject)")
            return UserInfoResponse(fromDictionary: dictionary)
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

    @objc internal func updateUserInfo(name: String,
                                     phone: String,
                                     email: String,
                                     gender: String? = nil,
                                     aniversary: Date? = nil,
                                     birthday: Date? = nil,
                                     completion: ((UserInfoUpdateResponse?) -> Void)?,
                                     failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/profile/?customer_phone=\(phone)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "PUT"
        
        var userInfo: [String: Any] = ["email": email,
                        "phone": phone,
                        "first_name": name] as [String: Any]
        
        if let string = gender {
            userInfo["gender"] = string
        }
        
        if let date = birthday {
            userInfo["birthday"] = date.timeIntervalSince1970 * 1000
        }
        
        if let date = aniversary {
            userInfo["anniversary"] = date.timeIntervalSince1970 * 1000
            userInfo["aniversary"] = date.timeIntervalSince1970 * 1000
        }
        
        let params: [String: Any] = ["user_data": userInfo]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> UserInfoUpdateResponse? in
            return UserInfoUpdateResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    
                    if let success: Bool = dictionary["success"] as? Bool, success {
                        
                        DispatchQueue.main.async {
                            completion?(userInfo)
                        }
                        return
                    } else {
                        DispatchQueue.main.async {
                            let apiError: UPError? = UPError(responseObject: dictionary)!
                            failure?(apiError)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion?(nil)
                    }
                } else {
                    let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
                }
                
            }
        }
        
        return dataTask*/
    }
    
    @objc internal func changePassword(phone: String,
                                     oldPassword: String,
                                     newPassword: String,
                                     completion: ((GenericResponse?) -> Void)?,
                                     failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/password/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "PUT"
        
        let params: [String: Any] = ["phone": phone,
                                   "biz_id": bizId,
                                   "old_password": oldPassword,
                                   "new_password1": newPassword,
                                   "new_password2": newPassword]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> GenericResponse? in
            return GenericResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    
                    if let status: String = dictionary["status"] as? String, status.lowercased() == "success" {
                        DispatchQueue.main.async {
                            completion?(dictionary)
                        }
                        return
                    } else {
                        DispatchQueue.main.async {
                            let apiError: UPError? = UPError(responseObject: dictionary)!
                            failure?(apiError)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion?(nil)
                    }
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
        }
        
        return dataTask*/
    }
    
    @objc internal func getSavedAddresses(completion: ((UserAddressesResponse?) -> Void)?,
                         failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/?biz_id=\(bizId)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> UserAddressesResponse? in
            return UserAddressesResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let userAddressesResponse: UserAddressesResponse = UserAddressesResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(userAddressesResponse)
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
    
    internal func getDeliverableAddresses(storeId: Int?,
                                          completion: ((UserAddressesResponse?) -> Void)?,
                                          failure: APIFailure?) -> URLSessionDataTask {
        
        var urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/"

        if let id = storeId {
            urlString = "\(urlString)?location_id=\(id)"
        } else {
            urlString = "\(urlString)?biz_id=\(bizId)"
        }
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> UserAddressesResponse? in
            return UserAddressesResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let userAddressesResponse: UserAddressesResponse = UserAddressesResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(userAddressesResponse)
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
    
    @objc internal func addAddress(address: Address,
                                 completion: ((AddUpdateAddressResponse?) -> Void)?,
                                 failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        var addressDict: [String: Any] = ["tag" : address.tag,
                           "biz_id" : bizId,
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
        
        addressDict["lat"] = address.lat
        addressDict["lng"] = address.lng
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: addressDict, options: [])
        
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> AddUpdateAddressResponse? in
            return AddUpdateAddressResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let addUpdateAddressResponse: AddUpdateAddressResponse = AddUpdateAddressResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(addUpdateAddressResponse)
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
    
    @objc internal func updateAddress(address: Address,
                                    completion: ((AddUpdateAddressResponse?) -> Void)?,
                                    failure: APIFailure?) -> URLSessionDataTask {
        

        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/"

        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        

        var addressDict: [String: Any] = ["tag": address.tag,
                           "id": address.id!,
                           "biz_id" : bizId,
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
        
        addressDict["lat"] = address.lat
        addressDict["lng"] = address.lng

        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: addressDict, options: [])
        
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> AddUpdateAddressResponse? in
            return AddUpdateAddressResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let addUpdateAddressResponse: AddUpdateAddressResponse = AddUpdateAddressResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(addUpdateAddressResponse)
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
    
    @objc internal func deleteAddress(addressId: Int,
                                    completion: ((GenericResponse?) -> Void)?,
                                    failure: APIFailure?) -> URLSessionDataTask {
        

        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/\(addressId)/?biz_id=\(bizId)"

        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "DELETE"
        
        
        return apiRequest(urlRequest: &urlRequest, responseParser: nil, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                DispatchQueue.main.async {
                    completion?()
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask*/
    }
}
