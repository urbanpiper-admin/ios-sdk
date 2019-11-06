// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let optionGroup = try OptionGroup(json)

import Foundation

// MARK: - OptionGroup
@objc public class OptionGroup: NSObject, JSONDecodable {
    @objc public let optionGroupDescription: String
    @objc public let displayInline: Bool
    @objc public let id: Int
    @objc public let isDefault: Bool
    @objc public let maxSelectable, minSelectable: Int
    @objc public let options: [OptionGroupOption]
    @objc public let sortOrder: Int
    @objc public let title: String

    enum CodingKeys: String, CodingKey {
        case optionGroupDescription = "description"
        case displayInline = "display_inline"
        case id
        case isDefault = "is_default"
        case maxSelectable = "max_selectable"
        case minSelectable = "min_selectable"
        case options
        case sortOrder = "sort_order"
        case title
    }

    init(optionGroupDescription: String, displayInline: Bool, id: Int, isDefault: Bool, maxSelectable: Int, minSelectable: Int, options: [OptionGroupOption], sortOrder: Int, title: String) {
        self.optionGroupDescription = optionGroupDescription
        self.displayInline = displayInline
        self.id = id
        self.isDefault = isDefault
        self.maxSelectable = maxSelectable
        self.minSelectable = minSelectable
        self.options = options
        self.sortOrder = sortOrder
        self.title = title
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OptionGroup.self, from: data)
        self.init(optionGroupDescription: me.optionGroupDescription, displayInline: me.displayInline, id: me.id, isDefault: me.isDefault, maxSelectable: me.maxSelectable, minSelectable: me.minSelectable, options: me.options, sortOrder: me.sortOrder, title: me.title)
    }
}

// MARK: OptionGroup convenience initializers and mutators

extension OptionGroup {

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
        optionGroupDescription: String? = nil,
        displayInline: Bool? = nil,
        id: Int? = nil,
        isDefault: Bool? = nil,
        maxSelectable: Int? = nil,
        minSelectable: Int? = nil,
        options: [OptionGroupOption]? = nil,
        sortOrder: Int? = nil,
        title: String? = nil
    ) -> OptionGroup {
        return OptionGroup(
            optionGroupDescription: optionGroupDescription ?? self.optionGroupDescription,
            displayInline: displayInline ?? self.displayInline,
            id: id ?? self.id,
            isDefault: isDefault ?? self.isDefault,
            maxSelectable: maxSelectable ?? self.maxSelectable,
            minSelectable: minSelectable ?? self.minSelectable,
            options: options ?? self.options,
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

extension OptionGroup {
    
    internal func equitableCheckDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        //        if let isDefault = isDefault {
        //            dictionary["is_default"] = isDefault as AnyObject
        //        }
        var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
        for optionsElement in options {
            guard optionsElement.quantity > 0 else { continue }
            dictionaryElements.append(optionsElement.equitableCheckDictionary())
        }
        dictionary["options"] = dictionaryElements as AnyObject

        return dictionary
    }

    public static func == (lhs: OptionGroup, rhs: OptionGroup) -> Bool {
        let lhsDictionary = lhs.equitableCheckDictionary()
        let rhsDictionary = rhs.equitableCheckDictionary()

        return NSDictionary(dictionary: lhsDictionary).isEqual(to: rhsDictionary)
    }
    
//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    // public func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        
//        dictionary["description"] = optionGroupDescription as AnyObject
//        
//        dictionary["id"] = id as AnyObject
//
//        dictionary["is_default"] = isDefault as AnyObject
//        
//        dictionary["max_selectable"] = maxSelectable as AnyObject
//        
//        dictionary["min_selectable"] = minSelectable as AnyObject
//        
//        var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//        for optionsElement in options {
//            dictionaryElements.append(optionsElement.toDictionary())
//        }
//        dictionary["options"] = dictionaryElements as AnyObject
//
//        dictionary["sort_order"] = sortOrder as AnyObject
//        dictionary["title"] = title as AnyObject
//
//        return dictionary
//    }
}
