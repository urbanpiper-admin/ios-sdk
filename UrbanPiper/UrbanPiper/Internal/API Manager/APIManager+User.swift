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
    case deliverableAddresses(storeId: Int?)
    case addAddress(newAddressBody: NewAddressBody)
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
        case let .updateUserData(_, phone, _, _, _, _):
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
        case let .addAddress(newAddressBody):
            let addressDict = ["tag": newAddressBody.tag as Any,
                               "biz_id": APIManager.shared.bizId,
                               "sub_locality": newAddressBody.subLocality as Any,
                               "address_1": newAddressBody.address1 as Any,
                               "landmark": newAddressBody.landmark as Any,
                               "city": newAddressBody.city as Any,
                               "pin": newAddressBody.pin as Any,
                               "lat": newAddressBody.lat as Any,
                               "lng": newAddressBody.lng as Any] as [String: AnyObject]

//            if let landmark = address.landmark {
//                addressDict["landmark"] = landmark as AnyObject
//            }
//
//            if let city = address.city {
//                addressDict["city"] = city as AnyObject
//            }
//
//            if let pin = address.pin {
//                addressDict["pin"] = pin as AnyObject
//            }
//
//            addressDict["lat"] = address.lat as AnyObject
//            addressDict["lng"] = address.lng as AnyObject
            return addressDict
        case let .updateAddress(address):
            let addressDict = ["tag": address.tag as Any,
                               "id": address.id as Any,
                               "biz_id": APIManager.shared.bizId,
                               "sub_locality": address.subLocality as Any,
                               "address_1": address.address1 as Any,
                               "landmark": address.landmark as Any,
                               "city": address.city as Any,
                               "pin": address.pin as Any,
                               "lat": address.lat as Any,
                               "lng": address.lng as Any] as [String: AnyObject]

//            if let landmark = address.landmark {
//                addressDict["landmark"] = landmark as AnyObject
//            }
//
//            if let city = address.city {
//                addressDict["city"] = city as AnyObject
//            }
//
//            if let pin = address.pin {
//                addressDict["pin"] = pin as AnyObject
//            }
//
//            addressDict["lat"] = address.lat as AnyObject
//            addressDict["lng"] = address.lng as AnyObject
//
            return addressDict
        case .deleteAddress:
            return nil
        }
    }
}
