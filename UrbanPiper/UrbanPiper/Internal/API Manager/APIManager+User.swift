//
//  APIManager+User.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum UserAPI {
    case userData(phone: String)
    case updateUserData(name: String, phone: String, email: String, gender: String?, aniversary: Date?, birthday: Date?)
    case changePassword(phone: String, oldPassword: String, newPassword: String)
    case savedAddresses
    case deliverableAddresses(storeId: String?)
    case addAddress(address: Address)
    case updateAddress(address: Address)
    case deleteAddress(addressId: Int)
}

extension UserAPI: UPAPI {
    var path: String {
        switch self {
        case .userData:
            return "api/v1/user/profile/"
        case .updateUserData:
            return "api/v1/user/profile/"
        case .changePassword:
            return "api/v1/user/password/"
        case .savedAddresses:
            return "api/v1/user/address/"
        case .deliverableAddresses:
            return "api/v1/user/address/"
        case .addAddress:
            return "api/v1/user/address/"
        case .updateAddress:
            return "api/v1/user/address/"
        case let .deleteAddress(addressId):
            return "api/v1/user/address/\(addressId)/"
        }
    }

    var parameters: [String: String]? {
        var params: [String: String]?
        switch self {
        case let .userData(phone):
            params = ["customer_phone": phone]
        case .updateUserData(_, let phone, _, _, _, _):
            params = ["customer_phone": phone]
        case .changePassword:
            params = ["biz_id": APIManager.shared.bizId]
        case .savedAddresses:
            params = ["biz_id": APIManager.shared.bizId]
        case let .deliverableAddresses(storeId):
            if let storeId = storeId {
                params = ["location_id": String(storeId)]
            } else {
                params = ["biz_id": APIManager.shared.bizId]
            }
        case .addAddress:
            params = nil
        case .updateAddress:
            params = nil
        case .deleteAddress:
            params = ["biz_id": APIManager.shared.bizId]
        }

        return params
    }

    var headers: [String: String]? {
        switch self {
        case .userData:
            return nil
        case .updateUserData:
            return nil
        case .changePassword:
            return nil
        case .savedAddresses:
            return nil
        case .deliverableAddresses:
            return nil
        case .addAddress:
            return nil
        case .updateAddress:
            return nil
        case .deleteAddress:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .userData:
            return .GET
        case .updateUserData:
            return .PUT
        case .changePassword:
            return .PUT
        case .savedAddresses:
            return .GET
        case .deliverableAddresses:
            return .GET
        case .addAddress:
            return .POST
        case .updateAddress:
            return .POST
        case .deleteAddress:
            return .DELETE
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .userData:
            return nil
        case let .updateUserData(name, phone, email, gender, aniversary, birthday):
            var userInfo: [String: AnyObject] = ["email": email,
                                                 "phone": phone,
                                                 "first_name": name] as [String: AnyObject]

            if let gender = gender {
                userInfo["gender"] = gender as AnyObject
            }

            if let birthday = birthday {
                userInfo["birthday"] = birthday.timeIntervalSince1970 * 1000 as AnyObject
            }

            if let aniversary = aniversary {
                userInfo["anniversary"] = aniversary.timeIntervalSince1970 * 1000 as AnyObject
                userInfo["aniversary"] = aniversary.timeIntervalSince1970 * 1000 as AnyObject
            }

            let params: [String: AnyObject] = ["user_data": userInfo] as [String: AnyObject]

            return params
        case let .changePassword(phone, oldPassword, newPassword):
            let params: [String: AnyObject] = ["phone": phone,
                                               "biz_id": APIManager.shared.bizId,
                                               "old_password": oldPassword,
                                               "new_password1": newPassword,
                                               "new_password2": newPassword] as [String: AnyObject]

            return params
        case .savedAddresses:
            return nil
        case .deliverableAddresses:
            return nil
        case let .addAddress(address):
            var addressDict = ["tag": address.tag as Any,
                               "biz_id": APIManager.shared.bizId,
                               "sub_locality": address.subLocality as Any,
                               "address_1": address.address1 as Any,
                               "landmark": "",
                               "city": "",
                               "pin": "",
                               "lat": Double(0),
                               "lng": Double(0)] as [String: AnyObject]

            if let landmark = address.landmark {
                addressDict["landmark"] = landmark as AnyObject
            }

            if let city = address.city {
                addressDict["city"] = city as AnyObject
            }

            if let pin = address.pin {
                addressDict["pin"] = pin as AnyObject
            }

            addressDict["lat"] = address.lat as AnyObject
            addressDict["lng"] = address.lng as AnyObject
            return addressDict
        case let .updateAddress(address):
            var addressDict = ["tag": address.tag as Any,
                               "id": address.id!,
                               "biz_id": APIManager.shared.bizId,
                               "sub_locality": address.subLocality as Any,
                               "address_1": address.address1 as Any,
                               "landmark": "",
                               "city": "",
                               "pin": "",
                               "lat": Double(0),
                               "lng": Double(0)] as [String: AnyObject]

            if let landmark = address.landmark {
                addressDict["landmark"] = landmark as AnyObject
            }

            if let city = address.city {
                addressDict["city"] = city as AnyObject
            }

            if let pin = address.pin {
                addressDict["pin"] = pin as AnyObject
            }

            addressDict["lat"] = address.lat as AnyObject
            addressDict["lng"] = address.lng as AnyObject

            return addressDict
        case .deleteAddress:
            return nil
        }
    }
}

/* extension APIManager {

 @objc internal func refreshUserData(phone: String,
                                   completion: APICompletion<UserInfoResponse>?,
                                   failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v1/user/profile/?customer_phone=\(phone)"

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "GET"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 @objc internal func updateUserInfo(name: String,
                                  phone: String,
                                  email: String,
                                  gender: String? = nil,
                                  aniversary: Date? = nil,
                                  birthday: Date? = nil,
                                  completion: APICompletion<UserInfoUpdateResponse>?,
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

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 @objc internal func changePassword(phone: String,
                                  oldPassword: String,
                                  newPassword: String,
                                  completion: APICompletion<GenericResponse>?,
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

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 @objc internal func getSavedAddresses(completion: APICompletion<UserAddressesResponse>?,
                      failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/?biz_id=\(bizId)"

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "GET"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 internal func getDeliverableAddresses(storeId: String?,
                                       completion: APICompletion<UserAddressesResponse>?,
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

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 @objc internal func addAddress(address: Address,
                              completion: APICompletion<AddUpdateAddressResponse>?,
                              failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/"

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "POST"

     var addressDict: [String: Any] = ["tag" : address.tag as Any,
                        "biz_id" : bizId,
                        "sub_locality" : address.subLocality as Any,
                        "address_1" : address.address1 as Any,
                        "landmark" : "",
                        "city" : "",
                        "pin" : "",
                        "lat" : Double(0),
                        "lng" : Double(0)]

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

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 @objc internal func updateAddress(address: Address,
                                 completion: APICompletion<AddUpdateAddressResponse>?,
                                 failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/"

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "POST"

     var addressDict: [String: Any] = ["tag": address.tag as Any,
                        "id": address.id!,
                        "biz_id" : bizId,
                        "sub_locality" : address.subLocality as Any,
                        "address_1" : address.address1 as Any,
                        "landmark" : "",
                        "city" : "",
                        "pin" : "",
                        "lat" : Double(0),
                        "lng" : Double(0)]

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

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 @objc internal func deleteAddress(addressId: Int,
                                 completion: APICompletion<GenericResponse>?,
                                 failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v1/user/address/\(addressId)/?biz_id=\(bizId)"

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "DELETE"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }
 }*/
