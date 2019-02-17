//
//	MyOrderItem.swift
//
//	Create by Vidhyadharan Mohanram on 16/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class MyOrderItem : NSObject{

	public var id : Int!
	public var image : String!
	public var imageLandscape : String!
	public var options : [MyOrderOption]!
	public var optionsToRemove : [AnyObject]!
	public var price : Decimal!
	public var quantity : Int!
//    public var srvcTaxRate : Float!
	public var title : String!
//    public var vatRate : Float!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? Int
		image = dictionary["image"] as? String
		imageLandscape = dictionary["image_landscape"] as? String
		options = [MyOrderOption]()
		if let optionsArray: [[String:Any]] = dictionary["options"] as? [[String:Any]]{
			for dic in optionsArray{
				let value: MyOrderOption = MyOrderOption(fromDictionary: dic)
				options.append(value)
			}
		}
		optionsToRemove = dictionary["options_to_remove"] as? [AnyObject]
        
        if let val: Decimal = dictionary["price"] as? Decimal {
            price = val
        } else if let val: Double = dictionary["price"] as? Double {
            price = Decimal(val).rounded
        } else {
            price = Decimal.zero
        }
        
		quantity = dictionary["quantity"] as? Int
//        srvcTaxRate = dictionary["srvc_tax_rate"] as? Float
		title = dictionary["title"] as? String
//        vatRate = dictionary["vat_rate"] as? Float
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if image != nil{
//            dictionary["image"] = image
//        }
//        if imageLandscape != nil{
//            dictionary["image_landscape"] = imageLandscape
//        }
//        if options != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for optionsElement in options {
//                dictionaryElements.append(optionsElement.toDictionary())
//            }
//            dictionary["options"] = dictionaryElements
//        }
//        if optionsToRemove != nil{
//            dictionary["options_to_remove"] = optionsToRemove
//        }
//        if price != nil{
//            dictionary["price"] = price
//        }
//        if quantity != nil{
//            dictionary["quantity"] = quantity
//        }
//        if srvcTaxRate != nil{
//            dictionary["srvc_tax_rate"] = srvcTaxRate
//        }
//        if title != nil{
//            dictionary["title"] = title
//        }
//        if vatRate != nil{
//            dictionary["vat_rate"] = vatRate
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         id = aDecoder.decodeObject(forKey: "id") as? Int
//         image = aDecoder.decodeObject(forKey: "image") as? String
//         imageLandscape = aDecoder.decodeObject(forKey: "image_landscape") as? String
//         options = aDecoder.decodeObject(forKey :"options") as? [MyOrderOption]
//         optionsToRemove = aDecoder.decodeObject(forKey: "options_to_remove") as? [AnyObject]
//         price = aDecoder.decodeObject(forKey: "price") as? Decimal
//         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
//         srvcTaxRate = aDecoder.decodeObject(forKey: "srvc_tax_rate") as? Float
//         title = aDecoder.decodeObject(forKey: "title") as? String
//         vatRate = aDecoder.decodeObject(forKey: "vat_rate") as? Float
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if image != nil{
//            aCoder.encode(image, forKey: "image")
//        }
//        if imageLandscape != nil{
//            aCoder.encode(imageLandscape, forKey: "image_landscape")
//        }
//        if options != nil{
//            aCoder.encode(options, forKey: "options")
//        }
//        if optionsToRemove != nil{
//            aCoder.encode(optionsToRemove, forKey: "options_to_remove")
//        }
//        if price != nil{
//            aCoder.encode(price, forKey: "price")
//        }
//        if quantity != nil{
//            aCoder.encode(quantity, forKey: "quantity")
//        }
//        if srvcTaxRate != nil{
//            aCoder.encode(srvcTaxRate, forKey: "srvc_tax_rate")
//        }
//        if title != nil{
//            aCoder.encode(title, forKey: "title")
//        }
//        if vatRate != nil{
//            aCoder.encode(vatRate, forKey: "vat_rate")
//        }
//
//    }

}
