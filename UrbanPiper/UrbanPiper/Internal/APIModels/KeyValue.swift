// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let keyValue = try KeyValue(json)

import Foundation

// MARK: - KeyValue
@objc public class KeyValue: NSObject, Codable {
    @objc public let id: Int
    @objc public let key, value: String

    init(id: Int, key: String, value: String) {
        self.id = id
        self.key = key
        self.value = value
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(KeyValue.self, from: data)
        self.init(id: me.id, key: me.key, value: me.value)
    }
}

// MARK: KeyValue convenience initializers and mutators

extension KeyValue {

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
        key: String? = nil,
        value: String? = nil
    ) -> KeyValue {
        return KeyValue(
            id: id ?? self.id,
            key: key ?? self.key,
            value: value ?? self.value
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
//    // public func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        dictionary["id"] = id as AnyObject
//        
//        dictionary["key"] = key as AnyObject
//
//        dictionary["value"] = value as AnyObject
//        
//        return dictionary
//    }
}
