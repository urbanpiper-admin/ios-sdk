// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let optionGroupOption = try OptionGroupOption(json)

import Foundation

// MARK: - OptionGroupOption
@objc public class OptionGroupOption: NSObject, Codable {
    @objc public let currentStock: Int
    @objc public let optionDescription, foodType: String
    @objc public let id: Int
    @objc public let imageurl: String?
    @objc public let optionGroups: [OptionGroup]?
    @objc public let price: Double
    @objc public let recommended: Bool
    @objc public let sortOrder: Int
    @objc public let title: String
    var quantity: Int = 0

    enum CodingKeys: String, CodingKey {
        case currentStock = "current_stock"
        case optionDescription = "description"
        case foodType = "food_type"
        case id
        case imageurl = "image_url"
        case optionGroups = "nested_option_groups"
        case price, recommended
        case sortOrder = "sort_order"
        case title
    }

    init(currentStock: Int, optionDescription: String, foodType: String, id: Int, imageurl: String?, optionGroups: [OptionGroup]?, price: Double, recommended: Bool, sortOrder: Int, title: String) {
        self.currentStock = currentStock
        self.optionDescription = optionDescription
        self.foodType = foodType
        self.id = id
        self.imageurl = imageurl
        self.optionGroups = optionGroups
        self.price = price
        self.recommended = recommended
        self.sortOrder = sortOrder
        self.title = title
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OptionGroupOption.self, from: data)
        self.init(currentStock: me.currentStock, optionDescription: me.optionDescription, foodType: me.foodType, id: me.id, imageurl: me.imageurl, optionGroups: me.optionGroups, price: me.price, recommended: me.recommended, sortOrder: me.sortOrder, title: me.title)
    }
}

// MARK: OptionGroupOption convenience initializers and mutators

extension OptionGroupOption {

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    public func with(
        currentStock: Int? = nil,
        optionDescription: String? = nil,
        foodType: String? = nil,
        id: Int? = nil,
        imageurl: String? = nil,
        optionGroups: [OptionGroup]? = nil,
        price: Double? = nil,
        recommended: Bool? = nil,
        sortOrder: Int? = nil,
        title: String? = nil
    ) -> OptionGroupOption {
        return OptionGroupOption(
            currentStock: currentStock ?? self.currentStock,
            optionDescription: optionDescription ?? self.optionDescription,
            foodType: foodType ?? self.foodType,
            id: id ?? self.id,
            imageurl: imageurl ?? self.imageurl,
            optionGroups: optionGroups ?? self.optionGroups,
            price: price ?? self.price,
            recommended: recommended ?? self.recommended,
            sortOrder: sortOrder ?? self.sortOrder,
            title: title ?? self.title
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension OptionGroupOption {
    
    internal func equitableCheckDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        //        if let currentStock = currentStock {
        //            dictionary["current_stock"] = currentStock as AnyObject
        //        }
        dictionary["id"] = id as AnyObject
        //        if let price = price {
        //            dictionary["price"] = price as AnyObject
        //        }
        //        if let title = title {
        //            dictionary["title"] = title as AnyObject
        //        }
        //        dictionary["quantity"] = quantity as AnyObject
        var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
        if let optionGroups = optionGroups {
            for optionGroupsElement in optionGroups {
                dictionaryElements.append(optionGroupsElement.equitableCheckDictionary())
            }
            dictionary["nested_option_groups"] = dictionaryElements as AnyObject
        }

        return dictionary
    }

    public static func == (lhs: OptionGroupOption, rhs: OptionGroupOption) -> Bool {
        let lhsDictionary = lhs.equitableCheckDictionary()
        let rhsDictionary = rhs.equitableCheckDictionary()

        return NSDictionary(dictionary: lhsDictionary).isEqual(to: rhsDictionary)

        //        return lhs.currentStock == rhs.currentStock  &&
        //            lhs.descriptionField == rhs.descriptionField  &&
        //            lhs.foodType == rhs.foodType  &&
        //            lhs.id == rhs.id  &&
        //            lhs.imageurl == rhs.imageurl  &&
        //            lhs.price == rhs.price  &&
        //            lhs.sortOrder == rhs.sortOrder  &&
        //            lhs.title  == rhs.title  &&
        //            lhs.nestedOptionGroups == rhs.nestedOptionGroups &&
        //            lhs.quantity  == rhs.quantity
    }
    
//    /**
//         * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//         */
//        // public func toDictionary() -> [String : AnyObject]
//        {
//            var dictionary: [String : AnyObject] = [String : AnyObject]()
//            dictionary["current_stock"] = currentStock as AnyObject
//            dictionary["description"] = optionDescription as AnyObject
//            dictionary["food_type"] = foodType as AnyObject
//            dictionary["id"] = id as AnyObject
//            if let imageurl = imageurl {
//                dictionary["image_url"] = imageurl as AnyObject
//            }
//            dictionary["price"] = price as AnyObject
//            dictionary["recommended"] = recommended as AnyObject
//            dictionary["sort_order"] = sortOrder as AnyObject
//            dictionary["title"] = title as AnyObject
//            if let optionGroups = optionGroups {
//                var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//                for optionGroupsElement in optionGroups {
//                    dictionaryElements.append(optionGroupsElement.toDictionary())
//                }
//                dictionary["nested_option_groups"] = dictionaryElements as AnyObject
//            }
//            dictionary["quantity"] = quantity as AnyObject
//            return dictionary
//        }
    
}
