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

	@objc public var authKey : String!
	public var biz : BizInfo!
	@objc public var email : String!
	public var message : String!
	@objc public var name : String!
	@objc public var phone : String!
    @objc public var gender : String?
	public var success : Bool!
	public var timestamp : String!
	@objc public var username : String!
    
    @objc public var password: String? {
        didSet {
            guard let passwordString = password, passwordString.count > 0 else { return }
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
    
    public var countryCode = "+\(AppConfigManager.shared.firRemoteConfigDefaults.defaultCountryCode!)"
    
    @objc public var phoneNumberWithCountryCode: String! {
        guard phone != nil, phone!.count > 0 else { return nil }
        let isdCodesArray = AppConfigManager.shared.firRemoteConfigDefaults.isdCodes!
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
		name = dictionary["name"] as? String
		phone = dictionary["phone"] as? String
		success = dictionary["success"] as? Bool ?? false
		timestamp = dictionary["timestamp"] as? String
		username = dictionary["username"] as? String
        gender = dictionary["gender"] as? String

        provider = nil
        accessToken = nil
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if authKey != nil{
			dictionary["authKey"] = authKey
		}
		if biz != nil{
			dictionary["biz"] = biz
		}
		if email != nil{
			dictionary["email"] = email
		}
		if message != nil{
			dictionary["message"] = message
		}
		if name != nil{
			dictionary["name"] = name
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
        if gender != nil{
            dictionary["gender"] = gender
        }
        dictionary["success"] = success
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
        
        dictionary["countryCode"] = countryCode
        
        if password != nil {
            dictionary["password"] = password
        }
        
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         authKey = aDecoder.decodeObject(forKey: "authKey") as? String
        biz = aDecoder.decodeObject(forKey: "biz") as? BizInfo
        email = aDecoder.decodeObject(forKey: "email") as? String
         message = aDecoder.decodeObject(forKey: "message") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         success = aDecoder.decodeObject(forKey: "success") as? Bool ?? false
         timestamp = aDecoder.decodeObject(forKey: "timestamp") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String
        gender = aDecoder.decodeObject(forKey: "gender") as? String

        if let providerString = aDecoder.decodeObject(forKey: "provider") as? String {
            provider = SocialLoginProvider(rawValue: providerString)
        }
        
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        countryCode = aDecoder.decodeObject(forKey: "countryCode") as! String
        
        password = aDecoder.decodeObject(forKey: "password") as? String
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
		if name != nil{
			aCoder.encode(name, forKey: "name")
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
	}

}
