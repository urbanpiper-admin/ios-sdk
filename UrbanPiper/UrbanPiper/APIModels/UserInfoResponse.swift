//
//  UserInfoResponse.swift
//  UrbanPiper
//
//  Created by Vid on 09/02/19.
//

import UIKit

@objc public class UserInfoResponse: NSObject, JSONDecodable {
    
    public var phone : String!
    public var firstName : String!
    public var email : String!
    
    public var lastName : String?
    public var gender : String?
    public var currentCity : String?
    public var birthday : Int?
    public var anniversary : Int?
    public var birthdayDate : String?
    public var anniversaryDate : String?
    public var address : String?



    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
       
        phone = dictionary["phone"] as? String
        firstName = dictionary["first_name"] as? String
        email = dictionary["email"] as? String
        
        lastName = dictionary["last_name"] as? String
        gender = dictionary["gender"] as? String
        currentCity = dictionary["current_city"] as? String
        birthday = dictionary["birthday"] as? Int
        anniversary = dictionary["anniversary"] as? Int
        birthdayDate = dictionary["birthday_date"] as? String
        anniversaryDate = dictionary["anniversary_date"] as? String
        address = dictionary["address"] as? String
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let phone = phone {
            dictionary["phone"] = phone as AnyObject
        }
        if let firstName = firstName {
            dictionary["first_name"] = firstName as AnyObject
        }
        if let email = email {
            dictionary["email"] = email as AnyObject
        }
        if let lastName = lastName {
            dictionary["last_name"] = lastName as AnyObject
        }
        if let gender = gender {
            dictionary["gender"] = gender as AnyObject
        }
        if let currentCity = currentCity {
            dictionary["current_city"] = currentCity as AnyObject
        }
        if let birthday = birthday {
            dictionary["birthday"] = birthday as AnyObject
        }
        if let anniversary = anniversary {
            dictionary["anniversary"] = anniversary as AnyObject
        }
        if let birthdayDate = birthdayDate {
            dictionary["birthday_date"] = birthdayDate as AnyObject
        }
        if let anniversaryDate = anniversaryDate {
            dictionary["anniversary_date"] = anniversaryDate as AnyObject
        }
        if let address = address {
            dictionary["address"] = address as AnyObject
        }
        
        return dictionary
    }
}
