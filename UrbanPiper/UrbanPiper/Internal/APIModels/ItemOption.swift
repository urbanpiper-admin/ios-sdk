// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let optionGroupOption = try OptionGroupOption(json)

import Foundation

// MARK: - OptionGroupOption

@objcMembers public class OptionGroupOption: NSObject, Codable {
    public let currentStock: Int
    public let optionDescription: String?
    public let foodType: String?
    public let id: Int
    public let imageurl: String?
    public let optionGroups: [OptionGroup]?
    public let price: Double
    public let recommended: Bool
    public let sortOrder: Int
    public let title: String
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

    init(currentStock: Int, optionDescription: String?, foodType: String?, id: Int, imageurl: String?, optionGroups: [OptionGroup]?, price: Double, recommended: Bool, sortOrder: Int, title: String) {
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
    
        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
    
            self.currentStock = try container.decodeIfPresent(Int.self, forKey: CodingKeys.currentStock) ?? 0
            self.optionDescription = try container.decodeIfPresent(String.self, forKey: CodingKeys.optionDescription)
            self.foodType = try container.decodeIfPresent(String.self, forKey: CodingKeys.foodType)
            self.id = try container.decode(Int.self, forKey: CodingKeys.id)
            self.imageurl = try container.decodeIfPresent(String.self, forKey: CodingKeys.imageurl)
            self.optionGroups = try container.decodeIfPresent([OptionGroup].self, forKey: CodingKeys.optionGroups)
            self.price = try container.decode(Double.self, forKey: CodingKeys.price)
            self.recommended = try container.decodeIfPresent(Bool.self, forKey: CodingKeys.recommended) ?? false
            self.sortOrder = try container.decodeIfPresent(Int.self, forKey: CodingKeys.sortOrder) ?? 0
            self.title = try container.decode(String.self, forKey: CodingKeys.title)
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
        OptionGroupOption(
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
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}

extension OptionGroupOption {
    internal func equitableCheckDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        dictionary["id"] = id as AnyObject

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
    }
}
