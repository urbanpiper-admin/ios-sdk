// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let choice = try Choice(json)

import Foundation

// MARK: - Choice
@objc public class Choice: NSObject, Codable, NSCoding {
    @objc public let id, sortOrder: Int
    @objc public let text: String

    enum CodingKeys: String, CodingKey {
        case id
        case sortOrder = "sort_order"
        case text
    }

    init(id: Int, sortOrder: Int, text: String) {
        self.id = id
        self.sortOrder = sortOrder
        self.text = text
    }
    
    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    required public init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeInteger(forKey: "id")
        sortOrder = aDecoder.decodeInteger(forKey: "sort_order")
        text = (aDecoder.decodeObject(forKey: "text") as? String)!

    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Choice.self, from: data)
        self.init(id: me.id, sortOrder: me.sortOrder, text: me.text)
    }
}

// MARK: Choice convenience initializers and mutators

extension Choice {

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
        id: Int? = nil,
        sortOrder: Int? = nil,
        text: String? = nil
    ) -> Choice {
        return Choice(
            id: id ?? self.id,
            sortOrder: sortOrder ?? self.sortOrder,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(sortOrder, forKey: "sort_order")
        aCoder.encode(text, forKey: "text")
    }

}
