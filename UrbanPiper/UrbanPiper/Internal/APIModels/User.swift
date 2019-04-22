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

    public var phoneVerified : Bool!

    @objc public var phone : String!
    @objc public var email : String!
    
    @objc public var gender : String?
    
    public var anniversary : Int!
    public var birthday : Int!
    
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
//    @objc internal init(fromDictionary dictionary:  [String:Any]){
//        super.init()
//        authKey = dictionary["authKey"] as? String
//        if let userBizInfoResponseData = dictionary["biz"] as? [String:Any]{
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
    
    @discardableResult public func update(fromDictionary dictionary: [String: Any]) -> User? {
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
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if authKey != nil{
            dictionary["authKey"] = authKey
        }
        if userBizInfoResponse != nil{
            dictionary["biz"] = userBizInfoResponse.toDictionary()
        }
        if email != nil{
            dictionary["email"] = email
        }
        if message != nil{
            dictionary["message"] = message
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if gender != nil{
            dictionary["gender"] = gender
        }
//        dictionary["success"] = success
        if timestamp != nil{
            dictionary["timestamp"] = timestamp
        }
        if username != nil{
            dictionary["username"] = username
        }
        
        if provider != nil {
            dictionary["provider"] = provider
        }
        
        if accessToken != nil {
            dictionary["accessToken"] = accessToken
        }
        
        if phoneVerified != nil {
            dictionary["phone_verified"] = phoneVerified
        }
        
//        dictionary["countryCode"] = countryCode
        
//        if password != nil {
//            dictionary["password"] = password
//        }
        
        if address != nil{
            dictionary["address"] = address
        }
        if anniversary != nil{
            dictionary["anniversary"] = anniversary
        }
//        if anniversaryDate != nil{
//            dictionary["anniversary_date"] = anniversaryDate
//        }
//        if birthdate != nil{
//            dictionary["birthdate"] = birthdate
//        }
        if birthday != nil{
            dictionary["birthday"] = birthday
        }
        if currentCity != nil{
            dictionary["current_city"] = currentCity
        }
        if firstName != nil{
            dictionary["first_name"] = firstName
        }
        if lastName != nil{
            dictionary["last_name"] = lastName
        }
//        if jwt != nil{
//            dictionary["jwt"] = jwt.toDictionary()
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
//         success = aDecoder.decodeObject(forKey: "success") as? Bool ?? false
         timestamp = aDecoder.decodeObject(forKey: "timestamp") as? String
//         username = aDecoder.decodeObject(forKey: "username") as? String
        gender = aDecoder.decodeObject(forKey: "gender") as? String
        phoneVerified = aDecoder.decodeObject(forKey: "phone_verified") as? Bool ?? false

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
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if authKey != nil{
			aCoder.encode(authKey, forKey: "authKey")
		}
		if userBizInfoResponse != nil{
			aCoder.encode(userBizInfoResponse, forKey: "biz")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if gender != nil{
            aCoder.encode(gender, forKey: "gender")
        }
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
        
//        if success != nil {
//            aCoder.encode(success, forKey: "success")
//        }
        
		if timestamp != nil{
			aCoder.encode(timestamp, forKey: "timestamp")
		}
		if username != nil{
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
        
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if anniversary != nil{
            aCoder.encode(anniversary, forKey: "anniversary")
        }
        if birthday != nil{
            aCoder.encode(birthday, forKey: "birthday")
        }
        if currentCity != nil{
            aCoder.encode(currentCity, forKey: "current_city")
        }
        if phoneVerified != nil {
            aCoder.encode(phoneVerified, forKey: "phone_verified")
        }
        if firstName != nil{
            aCoder.encode(firstName, forKey: "first_name")
        }
        if lastName != nil{
            aCoder.encode(lastName, forKey: "last_name")
        }
        if jwt != nil{
            aCoder.encode(jwt, forKey: "jwt")
        }
	}

}
