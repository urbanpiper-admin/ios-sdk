//
//  UserInfoResponse.swift
//  UrbanPiperSDK
//
//  Created by Vid on 09/02/19.
//

import UIKit

@objc public class UserInfoResponse: NSObject {
    
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
    init(fromDictionary dictionary: [String:Any]){
       
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
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if phone != nil{
            dictionary["phone"] = phone
        }
        if firstName != nil{
            dictionary["first_name"] = firstName
        }
        if email != nil{
            dictionary["email"] = email
        }
        if lastName != nil{
            dictionary["last_name"] = lastName
        }
        if gender != nil{
            dictionary["gender"] = gender
        }
        if currentCity != nil{
            dictionary["current_city"] = currentCity
        }
        if birthday != nil{
            dictionary["birthday"] = birthday
        }
        if anniversary != nil{
            dictionary["anniversary"] = anniversary
        }
        if birthdayDate != nil{
            dictionary["birthday_date"] = birthdayDate
        }
        if anniversaryDate != nil{
            dictionary["anniversary_date"] = anniversaryDate
        }
        if address != nil{
            dictionary["address"] = address
        }
        
        return dictionary
    }
}
