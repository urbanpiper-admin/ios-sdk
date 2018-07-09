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
    case invalid
    case invalidOTP
    
    public typealias RawValue = String
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "new_registration_required": self = .registrationRequired
        case "phone_number_required": self = .phoneNumberRequired
        case "userbiz_phone_not_validated": self = .verifyPhoneNumber
        case "User has successfully been registered and validated": self = .valid
        case "User has successfully been registered.": self = .registrationSuccessfullVerifyOTP
        case "otp_sent": self = .otpSent
        case "invalid_otp": self = .invalidOTP
        default: self = .invalid
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
        case .invalid: return "invalid"
        case .invalidOTP: return "invalid_otp"
        }
    }
}

public class User : NSObject, NSCoding{
    
    @objc public var firstName : String!
    public var lastName : String!
    @objc public var username : String!
    
    @objc public var phone : String!
    @objc public var email : String!
    
    @objc public var gender : String?
    
    public var anniversary : Int!
    public var anniversaryDate : String!
    public var birthdate : String!
    public var birthday : Int!
    
    public var currentCity : String!
    public var address : String!

	@objc public var authKey : String!
    
	public var biz : BizInfo!
    
	public var message : String!
	public var success : Bool!
	public var timestamp : String!

    @objc public var password: String? {
        didSet {
            guard let passwordString: String = password, passwordString.count > 0 else { return }
            accessToken = nil
            provider = nil
            APIManager.shared.updateHeaders()
        }
    }
    
    public var provider: SocialLoginProvider?
    public var accessToken: String? {
        didSet {
            guard let token = accessToken, token.count > 0 else { return }
            password = nil
        }
    }
    
    @objc public var userStatus: UserStatus {
        guard let msg = message else { return .invalid }
        return UserStatus(rawValue: msg) ?? .invalid
    }
    
    public var countryCode: String = "+\(AppConfigManager.shared.firRemoteConfigDefaults.defaultCountryCode!)"
    
    @objc public var phoneNumberWithCountryCode: String! {
        guard phone != nil, phone!.count > 0 else { return nil }
        let isdCodesArray: [[String : String]] = AppConfigManager.shared.firRemoteConfigDefaults.isdCodes!
        guard isdCodesArray.filter ({ phone.hasPrefix($0.keys.first!) }).count == 0 else { return phone }
        return "\(countryCode)\(phone!)"
    }
    public var phoneNumberWithOutCountryCode: String! {
        guard let phoneNo = phone else { return ""}
        return phoneNo.replacingOccurrences(of: countryCode, with: "")
    }
    
    public var isValid: Bool {
        if phone == nil && email == nil {
            return false
        } else if (phone == nil || phone.count == 0) && (email == nil || email.count == 0) {
            return false
        } else if password == nil && accessToken == nil {
            return false
        } else if (password == nil || password!.count == 0) && (accessToken == nil || accessToken!.count == 0) {
            return false
        }
        
        return true
    }
    
    public var birthdayDateObject: Date? {
        guard let dateIntVal = birthday else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(dateIntVal / 1000))
    }
    
    public var anniversaryDateObject: Date? {
        guard let anniversaryIntVal = anniversary else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(anniversaryIntVal / 1000))
    }

    public override init() {
        
    }
    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		authKey = dictionary["authKey"] as? String
		biz = dictionary["biz"] as? BizInfo
		email = dictionary["email"] as? String
		message = dictionary["message"] as? String ?? ""
		firstName = dictionary["name"] as? String
		phone = dictionary["phone"] as? String
		success = dictionary["success"] as? Bool ?? false
		timestamp = dictionary["timestamp"] as? String
		username = dictionary["username"] as? String
        gender = dictionary["gender"] as? String

        provider = nil
        accessToken = nil
	}
    
    public func update(fromDictionary dictionary: [String: Any]) {
        address = dictionary["address"] as? String
        anniversary = dictionary["anniversary"] as? Int
        anniversaryDate = dictionary["anniversary_date"] as? String
        birthdate = dictionary["birthdate"] as? String
        birthday = dictionary["birthday"] as? Int
        currentCity = dictionary["current_city"] as? String
        email = dictionary["email"] as? String
        firstName = dictionary["first_name"] as? String
        gender = dictionary["gender"] as? String
        lastName = dictionary["last_name"] as? String
        phone = dictionary["phone"] as? String
    }

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String : Any] = [String:Any]()
//        if authKey != nil{
//            dictionary["authKey"] = authKey
//        }
//        if biz != nil{
//            dictionary["biz"] = biz
//        }
//        if email != nil{
//            dictionary["email"] = email
//        }
//        if message != nil{
//            dictionary["message"] = message
//        }
//        if phone != nil{
//            dictionary["phone"] = phone
//        }
//        if gender != nil{
//            dictionary["gender"] = gender
//        }
//        dictionary["success"] = success
//        if timestamp != nil{
//            dictionary["timestamp"] = timestamp
//        }
//        if username != nil{
//            dictionary["username"] = username
//        }
//        
//        if provider != nil {
//            dictionary["provider"] = provider
//        }
//        
//        if accessToken != nil {
//            dictionary["accessToken"] = accessToken
//        }
//        
//        dictionary["countryCode"] = countryCode
//        
//        if password != nil {
//            dictionary["password"] = password
//        }
//        
//        if address != nil{
//            dictionary["address"] = address
//        }
//        if anniversary != nil{
//            dictionary["anniversary"] = anniversary
//        }
//        if anniversaryDate != nil{
//            dictionary["anniversary_date"] = anniversaryDate
//        }
//        if birthdate != nil{
//            dictionary["birthdate"] = birthdate
//        }
//        if birthday != nil{
//            dictionary["birthday"] = birthday
//        }
//        if currentCity != nil{
//            dictionary["current_city"] = currentCity
//        }
//        if firstName != nil{
//            dictionary["first_name"] = firstName
//        }
//        if lastName != nil{
//            dictionary["last_name"] = lastName
//        }
//        
//        return dictionary
//    }

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
        biz = aDecoder.decodeObject(forKey: "biz") as? BizInfo
        email = aDecoder.decodeObject(forKey: "email") as? String
         message = aDecoder.decodeObject(forKey: "message") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         success = aDecoder.decodeObject(forKey: "success") as? Bool ?? false
         timestamp = aDecoder.decodeObject(forKey: "timestamp") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String
        gender = aDecoder.decodeObject(forKey: "gender") as? String

        if let providerString: String = aDecoder.decodeObject(forKey: "provider") as? String {
            provider = SocialLoginProvider(rawValue: providerString)
        }
        
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        countryCode = aDecoder.decodeObject(forKey: "countryCode") as! String
        
        password = aDecoder.decodeObject(forKey: "password") as? String
        
        address = aDecoder.decodeObject(forKey: "address") as? String
        anniversary = aDecoder.decodeObject(forKey: "anniversary") as? Int
        anniversaryDate = aDecoder.decodeObject(forKey: "anniversary_date") as? String
        birthdate = aDecoder.decodeObject(forKey: "birthdate") as? String
        birthday = aDecoder.decodeObject(forKey: "birthday") as? Int
        currentCity = aDecoder.decodeObject(forKey: "current_city") as? String
        lastName = aDecoder.decodeObject(forKey: "last_name") as? String

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
		if biz != nil{
			aCoder.encode(biz, forKey: "biz")
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
        
        if success != nil {
            aCoder.encode(success, forKey: "success")
        }
        
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
        
        aCoder.encode(countryCode, forKey: "countryCode")
        
        if password != nil {
            aCoder.encode(password!, forKey: "password")
        }
        
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if anniversary != nil{
            aCoder.encode(anniversary, forKey: "anniversary")
        }
        if anniversaryDate != nil{
            aCoder.encode(anniversaryDate, forKey: "anniversary_date")
        }
        if birthdate != nil{
            aCoder.encode(birthdate, forKey: "birthdate")
        }
        if birthday != nil{
            aCoder.encode(birthday, forKey: "birthday")
        }
        if currentCity != nil{
            aCoder.encode(currentCity, forKey: "current_city")
        }
        if firstName != nil{
            aCoder.encode(firstName, forKey: "first_name")
        }
        if lastName != nil{
            aCoder.encode(lastName, forKey: "last_name")
        }
	}

}
