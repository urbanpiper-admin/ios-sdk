//
//  PastOrderItem.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on February 21, 2019

import Foundation


public class PastOrderItem : NSObject, JSONDecodable {//}, NSCoding{
    
    public var charges : [OrderCharges]!
    public var discount : Decimal!
    public var foodType : String!
    public var id : Int = 0
    public var imageLandscapeUrl : String!
    public var imageUrl : String!
    public var merchantId : String!
    public var optionsToAdd : [ItemOption]!
    public var optionsToRemove : [ItemOption]!
    public var price : Decimal!
    public var quantity : Int?
    public var taxes : [ItemTaxes]!
    public var title : String!
    public var total : Decimal!
    public var totalWithTax : Decimal!
    public var unitWeight : Int?
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        
        var priceVal = dictionary["discount"] as Any
        if let val: Decimal = priceVal as? Decimal {
            discount = val
        } else if let val: Double = priceVal as? Double {
            discount = Decimal(val).rounded
        } else {
            discount = Decimal.zero
        }
        
        foodType = dictionary["food_type"] as? String
        id = dictionary["id"] as? Int ?? 0
        imageLandscapeUrl = dictionary["image_landscape_url"] as? String
        imageUrl = dictionary["image_url"] as? String
        merchantId = dictionary["merchant_id"] as? String

        priceVal = dictionary["price"] as Any
        if let val: Decimal = priceVal as? Decimal {
            price = val
        } else if let val: Double = priceVal as? Double {
            price = Decimal(val).rounded
        } else {
            price = Decimal.zero
        }
        
        quantity = dictionary["quantity"] as? Int
        title = dictionary["title"] as? String
        
        priceVal = dictionary["total"] as Any
        if let val: Decimal = priceVal as? Decimal {
            total = val
        } else if let val: Double = priceVal as? Double {
            total = Decimal(val).rounded
        } else {
            total = Decimal.zero
        }
        
        priceVal = dictionary["total_with_tax"] as Any
        if let val: Decimal = priceVal as? Decimal {
            totalWithTax = val
        } else if let val: Double = priceVal as? Double {
            totalWithTax = Decimal(val).rounded
        } else {
            totalWithTax = Decimal.zero
        }
        
        unitWeight = dictionary["unit_weight"] as? Int
        
        optionsToAdd = [ItemOption]()
        if let optionsToAddArray = dictionary["options_to_add"] as? [[String : AnyObject]]{
            for dic in optionsToAddArray{
                guard let value = ItemOption(fromDictionary: dic) else { continue }
                optionsToAdd.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String : AnyObject]
    {
        var dictionary = [String : AnyObject]()
        if let discount = discount {
            dictionary["discount"] = discount as AnyObject
        }
        if let foodType = foodType {
            dictionary["food_type"] = foodType as AnyObject
        }
        dictionary["id"] = id as AnyObject
        if let imageLandscapeUrl = imageLandscapeUrl {
            dictionary["image_landscape_url"] = imageLandscapeUrl as AnyObject
        }
        if let imageUrl = imageUrl {
            dictionary["image_url"] = imageUrl as AnyObject
        }
        if let merchantId = merchantId {
            dictionary["merchant_id"] = merchantId as AnyObject
        }
        if let price = price {
            dictionary["price"] = price as AnyObject
        }
        if let quantity = quantity {
            dictionary["quantity"] = quantity as AnyObject
        }
        if let title = title {
            dictionary["title"] = title as AnyObject
        }
        if let total = total {
            dictionary["total"] = total as AnyObject
        }
        if let totalWithTax = totalWithTax {
            dictionary["total_with_tax"] = totalWithTax as AnyObject
        }
        if let unitWeight = unitWeight {
            dictionary["unit_weight"] = unitWeight as AnyObject
        }
        if let optionsToAdd = optionsToAdd {
            var dictionaryElements = [[String : AnyObject]]()
            for optionsToAddElement in optionsToAdd {
                dictionaryElements.append(optionsToAddElement.toDictionary())
            }
            dictionary["optionsToAdd"] = dictionaryElements as AnyObject
        }
        return dictionary
    }
    
/*    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        charges = aDecoder.decodeObject(forKey: "charges") as? [AnyObject]
        discount = aDecoder.decodeObject(forKey: "discount") as? Int
        foodType = aDecoder.decodeObject(forKey: "food_type") as? String
        if let val = aDecoder.decodeObject(forKey: "id") as? Int {
            id = val
        } else {
            id = aDecoder.decodeInteger(forKey: "id")
        }
        imageLandscapeUrl = aDecoder.decodeObject(forKey: "image_landscape_url") as? String
        imageUrl = aDecoder.decodeObject(forKey: "image_url") as? String
        merchantId = aDecoder.decodeObject(forKey: "merchant_id") as? String
        optionsToAdd = aDecoder.decodeObject(forKey: "options_to_add") as? [OptionsToAdd]
        optionsToRemove = aDecoder.decodeObject(forKey: "options_to_remove") as? [AnyObject]
        price = aDecoder.decodeObject(forKey: "price") as? Int
        quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
        taxes = aDecoder.decodeObject(forKey: "taxes") as? [AnyObject]
        title = aDecoder.decodeObject(forKey: "title") as? String
        total = aDecoder.decodeObject(forKey: "total") as? Int
        totalWithTax = aDecoder.decodeObject(forKey: "total_with_tax") as? Int
        unitWeight = aDecoder.decodeObject(forKey: "unit_weight") as? Int
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if let charges = charges {
            aCoder.encode(charges, forKey: "charges")
        }
        if let discount = discount {
            aCoder.encode(discount, forKey: "discount")
        }
        if let foodType = foodType {
            aCoder.encode(foodType, forKey: "food_type")
        }
        if let id = id {
            aCoder.encode(id, forKey: "id")
        }
        if let imageLandscapeUrl = imageLandscapeUrl {
            aCoder.encode(imageLandscapeUrl, forKey: "image_landscape_url")
        }
        if let imageUrl = imageUrl {
            aCoder.encode(imageUrl, forKey: "image_url")
        }
        if let merchantId = merchantId {
            aCoder.encode(merchantId, forKey: "merchant_id")
        }
        if let optionsToAdd = optionsToAdd {
            aCoder.encode(optionsToAdd, forKey: "options_to_add")
        }
        if let optionsToRemove = optionsToRemove {
            aCoder.encode(optionsToRemove, forKey: "options_to_remove")
        }
        if let price = price {
            aCoder.encode(price, forKey: "price")
        }
        if let quantity = quantity {
            aCoder.encode(quantity, forKey: "quantity")
        }
        if let taxes = taxes {
            aCoder.encode(taxes, forKey: "taxes")
        }
        if let title = title {
            aCoder.encode(title, forKey: "title")
        }
        if let total = total {
            aCoder.encode(total, forKey: "total")
        }
        if let totalWithTax = totalWithTax {
            aCoder.encode(totalWithTax, forKey: "total_with_tax")
        }
        if let unitWeight = unitWeight {
            aCoder.encode(unitWeight, forKey: "unit_weight")
        }
    }*/
}
