// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let meta = try Meta(json)

import Foundation

// MARK: - Meta
@objcMembers public class Meta: NSObject, Codable, NSCoding {
    public let limit: Int
    public let next: String?
    public let offset: Int
    public let previous: String?
    public let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case limit, next, offset, previous
        case totalCount = "total_count"
    }

    init(limit: Int, next: String?, offset: Int, previous: String?, totalCount: Int) {
        self.limit = limit
        self.next = next
        self.offset = offset
        self.previous = previous
        self.totalCount = totalCount
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    public required init(coder aDecoder: NSCoder) {
        limit = aDecoder.decodeInteger(forKey: "limit")
        next = aDecoder.decodeObject(forKey: "next") as? String
        offset = aDecoder.decodeInteger(forKey: "offset")
        previous = aDecoder.decodeObject(forKey: "previous") as? String
        totalCount = aDecoder.decodeInteger(forKey: "total_count")
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Meta.self, from: data)
        self.init(limit: me.limit, next: me.next, offset: me.offset, previous: me.previous, totalCount: me.totalCount)
    }
}

// MARK: Meta convenience initializers and mutators

extension Meta {

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
        limit: Int? = nil,
        next: String? = nil,
        offset: Int? = nil,
        previous: String? = nil,
        totalCount: Int? = nil
    ) -> Meta {
        return Meta(
            limit: limit ?? self.limit,
            next: next ?? self.next,
            offset: offset ?? self.offset,
            previous: previous ?? self.previous,
            totalCount: totalCount ?? self.totalCount
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    // public func toDictionary() -> [String: AnyObject] {
//        var dictionary: [String: AnyObject] = [String: AnyObject]()
//        dictionary["limit"] = limit as AnyObject
//
//        if let next = next {
//            dictionary["next"] = next as AnyObject
//        }
//
//        dictionary["offset"] = offset as AnyObject
//
//        if let previous = previous {
//            dictionary["previous"] = previous as AnyObject
//        }
//
//        dictionary["total_count"] = totalCount as AnyObject
//
//        return dictionary
//    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(limit, forKey: "limit")

        if let next = next {
            aCoder.encode(next, forKey: "next")
        }

        aCoder.encode(offset, forKey: "offset")

        if let previous = previous {
            aCoder.encode(previous, forKey: "previous")
        }

        aCoder.encode(totalCount, forKey: "total_count")
    }
}
