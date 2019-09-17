//
//	User.swift
//
//	Create by Vidhyadharan Mohanram on 11/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

@objc public enum UserStatus: Int, RawRepresentable {
    case registrationRequired
    case phoneNumberRequired
    case verifyPhoneNumber
    case registrationSuccessfullVerifyOTP
    case otpSent
    case valid
    
    public typealias RawValue = String
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "new_registration_required": self = .registrationRequired
        case "phone_number_required": self = .phoneNumberRequired
        case "userbiz_phone_not_validated": self = .verifyPhoneNumber
        case "User has successfully been registered and validated": self = .valid
        case "User has successfully been registered.": self = .registrationSuccessfullVerifyOTP
        case "otp_sent": self = .otpSent
        default:
            return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .registrationRequired: return "new_registration_required"
        case .phoneNumberRequired: return "phone_number_required"
        case .verifyPhoneNumber: return "userbiz_phone_not_validated"
        case .registrationSuccessfullVerifyOTP: return "User has successfully been registered."
        case .otpSent: return "otp_sent"
        case .valid: return "User has successfully been registered and validated"
        }
    }
}

public class User : NSObject, NSCoding{
    
    @objc public var firstName : String!
    public var lastName : String!
    @objc public var username : String? {
        if var phoneNo = phone {
            if phoneNo.hasPrefix("+") {
                phoneNo = String(phoneNo.dropFirst())
            }
            return "u_\(phoneNo)_\(APIManager.shared.bizId)"
//            u_918903464104_35041870
        } else {
            return nil
        }
    }
    @objc public var phoneVerified : Bool = false

    @objc public var phone : String!
    @objc public var email : String!
    
    @objc public var gender : String?
    
    public var anniversary : Int?
    public var birthday : Int?
    
    public var currentCity : String!
    public var address : String!

	@objc public var authKey : String!
    
	@objc public var userBizInfoResponse : UserBizInfoResponse!
    
    @objc public var message : String?
//    public var success : Bool!
	internal var timestamp : String!
    internal var jwt: JWT!

//    @objc public var password: String? {
//        didSet {
//            guard let passwordString: String = password, passwordString.count > 0 else { return }
//            accessToken = nil
//            provider = nil
//        }
//    }
    
    public var provider: SocialLoginProvider?
    public var accessToken: String?
//    {
//        didSet {
//            guard let token = accessToken, token.count > 0 else { return }
//            password = nil
//        }
//    }
    
//    @objc public var userStatus: UserStatus {
//        guard let msg = message else { return .invalid }
//        return UserStatus(rawValue: msg) ?? .invalid
//    }
    
    public var birthdayDateObject: Date? {
        guard let dateIntVal = birthday else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(dateIntVal / 1000))
    }
    
    public var anniversaryDateObject: Date? {
        guard let anniversaryIntVal = anniversary else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(anniversaryIntVal / 1000))
    }

    private override init() {
        
    }
    
//    /**
//     * Instantiate the instance using the passed dictionary values to set the properties values
//     */
//    @objc internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
//        guard let dictionary = dictionary else { return nil }
//        super.init()
//        authKey = dictionary["authKey"] as? String
//        if let userBizInfoResponseData = dictionary["biz"] as? [String : AnyObject]{
//            userBizInfoResponse = UserBizInfoResponse(fromDictionary: userBizInfoResponseData)
//        }
//        email = dictionary["email"] as? String
//        message = dictionary["message"] as? String
//        if let fn: String = dictionary["first_name"] as? String {
//            firstName = fn
//        } else {
//            firstName = dictionary["name"] as? String
//        }
//        phone = dictionary["phone"] as? String
////        success = dictionary["success"] as? Bool ?? false
//        timestamp = dictionary["timestamp"] as? String
////        username = dictionary["username"] as? String
//        gender = dictionary["gender"] as? String
//
////        password = dictionary["password"] as? String
//
//        provider = nil
//        accessToken = nil
//
//        if let token = dictionary["token"] as? String {
//            update(fromJWTToken: token)
//        }
//    }
    
    @discardableResult public func update(fromDictionary dictionary: [String : AnyObject]) -> User? {
        address = dictionary["address"] as? String
        birthday = dictionary["birthday"] as? Int
        currentCity = dictionary["current_city"] as? String
        email = dictionary["email"] as? String
        firstName = dictionary["first_name"] as? String
        gender = dictionary["gender"] as? String
        lastName = dictionary["last_name"] as? String
        phone = dictionary["phone"] as? String
        
        if let anniversaryVal = dictionary["anniversary"] as? Int {
            anniversary = anniversaryVal
        }

        if let birthdayVal = dictionary["birthday"] as? Int {
            birthday = birthdayVal
        }

        return self
    }
    
    public convenience init(jwtToken: String) {
        self.init()
        update(fromJWTToken: jwtToken)
    }
    
    @discardableResult public func update(fromJWTToken jwtToken: String) -> User {
        jwt = JWT(jwtToken: jwtToken)
        let dictionary = JWT.decode(jwtToken: jwtToken)
        if let authKey = dictionary["t_key"] as? String {
            self.authKey = authKey
        }
//        self?.username = dictionary["username"] as? String
        email = dictionary["email"] as? String
        phone = dictionary["phone"] as? String
        phoneVerified = dictionary["phone_verified"] as? Bool ?? false
        firstName = dictionary["first_name"] as? String
        lastName = dictionary["last_name"] as? String
        
//        message = UserStatus.valid.rawValue
        return self
    }
    
    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let authKey = authKey {
            dictionary["authKey"] = authKey as AnyObject
        }
        if let userBizInfoResponse = userBizInfoResponse {
            dictionary["biz"] = userBizInfoResponse.toDictionary() as AnyObject
        }
        if let email = email {
            dictionary["email"] = email as AnyObject
        }
        if let message = message {
            dictionary["message"] = message as AnyObject
        }
        if let phone = phone {
            dictionary["phone"] = phone as AnyObject
        }
        if let gender = gender {
            dictionary["gender"] = gender as AnyObject
        }
//        dictionary["success"] = success as AnyObject
        if let timestamp = timestamp {
            dictionary["timestamp"] = timestamp as AnyObject
        }
        if let username = username {
            dictionary["username"] = username as AnyObject
        }
        
        if provider != nil {
            dictionary["provider"] = provider as AnyObject
        }
        
        if accessToken != nil {
            dictionary["accessToken"] = accessToken as AnyObject
        }
        
        dictionary["phone_verified"] = phoneVerified as AnyObject
        
//        dictionary["countryCode"] = countryCode as AnyObject
        
//        if password != nil {
//            dictionary["password"] = password as AnyObject
//        }
        
        if let address = address {
            dictionary["address"] = address as AnyObject
        }
        if let anniversary = anniversary {
            dictionary["anniversary"] = anniversary as AnyObject
        }
//        if let anniversaryDate = anniversaryDate {
//            dictionary["anniversary_date"] = anniversaryDate as AnyObject
//        }
//        if let birthdate = birthdate {
//            dictionary["birthdate"] = birthdate as AnyObject
//        }
        if let birthday = birthday {
            dictionary["birthday"] = birthday as AnyObject
        }
        if let currentCity = currentCity {
            dictionary["current_city"] = currentCity as AnyObject
        }
        if let firstName = firstName {
            dictionary["first_name"] = firstName as AnyObject
        }
        if let lastName = lastName {
            dictionary["last_name"] = lastName as AnyObject
        }
//        if let jwt = jwt {
//            dictionary["jwt"] = jwt.toDictionary() as AnyObject
//        }
        
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
        
        if let fn: String = aDecoder.decodeObject(forKey: "first_name") as? String {
            firstName = fn
        } else {
            firstName = aDecoder.decodeObject(forKey: "name") as? String
        }

         authKey = aDecoder.decodeObject(forKey: "authKey") as? String
        userBizInfoResponse = aDecoder.decodeObject(forKey: "biz") as? UserBizInfoResponse
        email = aDecoder.decodeObject(forKey: "email") as? String
         message = aDecoder.decodeObject(forKey: "message") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
//         success = aDecoder.decodeBool(forKey: "success") ?? false
         timestamp = aDecoder.decodeObject(forKey: "timestamp") as? String
//         username = aDecoder.decodeObject(forKey: "username") as? String
        gender = aDecoder.decodeObject(forKey: "gender") as? String
        
        if let numberVal = aDecoder.decodeObject(forKey: "phone_verified") as? NSNumber {
            phoneVerified = numberVal == 0 ? false : true
        } else if aDecoder.containsValue(forKey: "phone_verified") {
            phoneVerified = aDecoder.decodeBool(forKey: "phone_verified")
        } else {
            phoneVerified = false
        }

        if let providerString: String = aDecoder.decodeObject(forKey: "provider") as? String {
            provider = SocialLoginProvider(rawValue: providerString)
        }
        
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
//        countryCode = aDecoder.decodeObject(forKey: "countryCode") as! String
        
//        password = aDecoder.decodeObject(forKey: "password") as? String
        
        address = aDecoder.decodeObject(forKey: "address") as? String
        anniversary = aDecoder.decodeObject(forKey: "anniversary") as? Int
        birthday = aDecoder.decodeObject(forKey: "birthday") as? Int
        currentCity = aDecoder.decodeObject(forKey: "current_city") as? String
        lastName = aDecoder.decodeObject(forKey: "last_name") as? String
        jwt = aDecoder.decodeObject(forKey: "jwt") as? JWT
        
        if jwt?.token != nil {
            let dictionary = JWT.decode(jwtToken: jwt.token)
            phoneVerified = dictionary["phone_verified"] as? Bool ?? false
        }
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if let authKey = authKey {
			aCoder.encode(authKey, forKey: "authKey")
		}
		if let userBizInfoResponse = userBizInfoResponse {
			aCoder.encode(userBizInfoResponse, forKey: "biz")
		}
		if let email = email {
			aCoder.encode(email, forKey: "email")
		}
        if let message = message {
            aCoder.encode(message, forKey: "message")
        }
        if let gender = gender {
            aCoder.encode(gender, forKey: "gender")
        }
		if let phone = phone {
			aCoder.encode(phone, forKey: "phone")
		}
        
//        if success != nil {
//            aCoder.encode(success, forKey: "success")
//        }
        
		if let timestamp = timestamp {
			aCoder.encode(timestamp, forKey: "timestamp")
		}
		if let username = username {
			aCoder.encode(username, forKey: "username")
		}
        
        if provider != nil {
            aCoder.encode(provider!.rawValue, forKey: "provider")
        }
        
        if accessToken != nil {
            aCoder.encode(accessToken!, forKey: "accessToken")
        }
        
//        aCoder.encode(countryCode, forKey: "countryCode")
        
//        if password != nil {
//            aCoder.encode(password!, forKey: "password")
//        }
        
        if let address = address {
            aCoder.encode(address, forKey: "address")
        }
        if let anniversary = anniversary {
            aCoder.encode(anniversary, forKey: "anniversary")
        }
        if let birthday = birthday {
            aCoder.encode(birthday, forKey: "birthday")
        }
        if let currentCity = currentCity {
            aCoder.encode(currentCity, forKey: "current_city")
        }
        aCoder.encode(phoneVerified, forKey: "phone_verified")
        if let firstName = firstName {
            aCoder.encode(firstName, forKey: "first_name")
        }
        if let lastName = lastName {
            aCoder.encode(lastName, forKey: "last_name")
        }
        if let jwt = jwt {
            aCoder.encode(jwt, forKey: "jwt")
        }
	}

}
