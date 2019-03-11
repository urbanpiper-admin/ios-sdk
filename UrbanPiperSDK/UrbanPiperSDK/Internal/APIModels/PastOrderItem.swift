//
//  PastOrderItem.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on February 21, 2019

import Foundation


public class PastOrderItem : NSObject {//}, NSCoding{
    
    public private(set)  var charges : [OrderCharges]!
    public private(set)  var discount : Decimal!
    public private(set)  var foodType : String!
    public private(set)  var id : Int!
    public private(set)  var imageLandscapeUrl : String!
    public private(set)  var imageUrl : String!
    public private(set)  var merchantId : String!
    public private(set)  var optionsToAdd : [ItemOption]!
    public private(set)  var optionsToRemove : [ItemOption]!
    public private(set)  var price : Decimal!
    public private(set)  var quantity : Int!
    public private(set)  var taxes : [ItemTaxes]!
    public private(set)  var title : String!
    public private(set)  var total : Decimal!
    public private(set)  var totalWithTax : Decimal!
    public private(set)  var unitWeight : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        
        var priceVal = dictionary["discount"] as Any
        if let val: Decimal = priceVal as? Decimal {
            discount = val
        } else if let val: Double = priceVal as? Double {
            discount = Decimal(val).rounded
        } else {
            discount = Decimal.zero
        }
        
        foodType = dictionary["food_type"] as? String
        id = dictionary["id"] as? Int
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
        if let optionsToAddArray = dictionary["options_to_add"] as? [[String:Any]]{
            for dic in optionsToAddArray{
                let value = ItemOption(fromDictionary: dic)
                optionsToAdd.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if discount != nil{
            dictionary["discount"] = discount
        }
        if foodType != nil{
            dictionary["food_type"] = foodType
        }
        if id != nil{
            dictionary["id"] = id
        }
        if imageLandscapeUrl != nil{
            dictionary["image_landscape_url"] = imageLandscapeUrl
        }
        if imageUrl != nil{
            dictionary["image_url"] = imageUrl
        }
        if merchantId != nil{
            dictionary["merchant_id"] = merchantId
        }
        if price != nil{
            dictionary["price"] = price
        }
        if quantity != nil{
            dictionary["quantity"] = quantity
        }
        if title != nil{
            dictionary["title"] = title
        }
        if total != nil{
            dictionary["total"] = total
        }
        if totalWithTax != nil{
            dictionary["total_with_tax"] = totalWithTax
        }
        if unitWeight != nil{
            dictionary["unit_weight"] = unitWeight
        }
        if optionsToAdd != nil{
            var dictionaryElements = [[String:Any]]()
            for optionsToAddElement in optionsToAdd {
                dictionaryElements.append(optionsToAddElement.toDictionary())
            }
            dictionary["optionsToAdd"] = dictionaryElements
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
        id = aDecoder.decodeObject(forKey: "id") as? Int
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
        if charges != nil{
            aCoder.encode(charges, forKey: "charges")
        }
        if discount != nil{
            aCoder.encode(discount, forKey: "discount")
        }
        if foodType != nil{
            aCoder.encode(foodType, forKey: "food_type")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if imageLandscapeUrl != nil{
            aCoder.encode(imageLandscapeUrl, forKey: "image_landscape_url")
        }
        if imageUrl != nil{
            aCoder.encode(imageUrl, forKey: "image_url")
        }
        if merchantId != nil{
            aCoder.encode(merchantId, forKey: "merchant_id")
        }
        if optionsToAdd != nil{
            aCoder.encode(optionsToAdd, forKey: "options_to_add")
        }
        if optionsToRemove != nil{
            aCoder.encode(optionsToRemove, forKey: "options_to_remove")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if quantity != nil{
            aCoder.encode(quantity, forKey: "quantity")
        }
        if taxes != nil{
            aCoder.encode(taxes, forKey: "taxes")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if total != nil{
            aCoder.encode(total, forKey: "total")
        }
        if totalWithTax != nil{
            aCoder.encode(totalWithTax, forKey: "total_with_tax")
        }
        if unitWeight != nil{
            aCoder.encode(unitWeight, forKey: "unit_weight")
        }
    }*/
}
