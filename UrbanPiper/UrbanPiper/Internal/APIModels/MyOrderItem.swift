//
//	MyOrderItem.swift
//
//	Create by Vidhyadharan Mohanram on 16/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

@objcMembers public class MyOrderItem: NSObject, JSONDecodable {
    public var id: Int = 0
    public var image: String!
    public var imageLandscape: String!
    public var options: [MyOrderOption]!
    public var optionsToRemove: [AnyObject]!
    public var price: Decimal!
    public var quantity: Int?
//    public var srvcTaxRate : Float!
    public var title: String!
//    public var vatRate : Float!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        id = dictionary["id"] as? Int ?? 0
        image = dictionary["image"] as? String
        imageLandscape = dictionary["image_landscape"] as? String
        options = [MyOrderOption]()
        if let optionsArray: [[String: AnyObject]] = dictionary["options"] as? [[String: AnyObject]] {
            for dic in optionsArray {
                guard let value: MyOrderOption = MyOrderOption(fromDictionary: dic) else { continue }
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
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let id = id {
//            dictionary["id"] = id as AnyObject
//        }
//        if let image = image {
//            dictionary["image"] = image as AnyObject
//        }
//        if let imageLandscape = imageLandscape {
//            dictionary["image_landscape"] = imageLandscape as AnyObject
//        }
//        if let options = options {
//            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//            for optionsElement in options {
//                dictionaryElements.append(optionsElement.toDictionary())
//            }
//            dictionary["options"] = dictionaryElements as AnyObject
//        }
//        if let optionsToRemove = optionsToRemove {
//            dictionary["options_to_remove"] = optionsToRemove as AnyObject
//        }
//        if let price = price {
//            dictionary["price"] = price as AnyObject
//        }
//        if let quantity = quantity {
//            dictionary["quantity"] = quantity as AnyObject
//        }
//        if let srvcTaxRate = srvcTaxRate {
//            dictionary["srvc_tax_rate"] = srvcTaxRate as AnyObject
//        }
//        if let title = title {
//            dictionary["title"] = title as AnyObject
//        }
//        if let vatRate = vatRate {
//            dictionary["vat_rate"] = vatRate as AnyObject
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    required public init(coder aDecoder: NSCoder)
//    {
//         if let val = aDecoder.decodeObject(forKey: "id") as? Int {
//            id = val
//         } else {
//            id = aDecoder.decodeInteger(forKey: "id")
//         }
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
//    public func encode(with aCoder: NSCoder)
//    {
//        if let id = id {
//            aCoder.encode(id, forKey: "id")
//        }
//        if let image = image {
//            aCoder.encode(image, forKey: "image")
//        }
//        if let imageLandscape = imageLandscape {
//            aCoder.encode(imageLandscape, forKey: "image_landscape")
//        }
//        if let options = options {
//            aCoder.encode(options, forKey: "options")
//        }
//        if let optionsToRemove = optionsToRemove {
//            aCoder.encode(optionsToRemove, forKey: "options_to_remove")
//        }
//        if let price = price {
//            aCoder.encode(price, forKey: "price")
//        }
//        if let quantity = quantity {
//            aCoder.encode(quantity, forKey: "quantity")
//        }
//        if let srvcTaxRate = srvcTaxRate {
//            aCoder.encode(srvcTaxRate, forKey: "srvc_tax_rate")
//        }
//        if let title = title {
//            aCoder.encode(title, forKey: "title")
//        }
//        if let vatRate = vatRate {
//            aCoder.encode(vatRate, forKey: "vat_rate")
//        }
//
//    }
}
