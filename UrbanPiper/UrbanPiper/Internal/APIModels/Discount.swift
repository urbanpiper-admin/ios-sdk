// Discount.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let discount = try Discount(json)

import Foundation

// MARK: - Discount
@objc public class Discount: NSObject, Codable {
    @objc public let msg: String?
    @objc public let success: Bool
    @objc public let value: Double

    init(msg: String?, success: Bool, value: Double) {
        self.msg = msg
        self.success = success
        self.value = value
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Discount.self, from: data)
        self.init(msg: me.msg, success: me.success, value: me.value)
    }
}

// MARK: Discount convenience initializers and mutators

extension Discount {

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
        msg: String? = nil,
        success: Bool? = nil,
        value: Double? = nil
    ) -> Discount {
        return Discount(
            msg: msg ?? self.msg,
            success: success ?? self.success,
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
//        dictionary["msg"] = msg as AnyObject
//
//        dictionary["success"] = success as AnyObject
//        
//        dictionary["value"] = value as AnyObject
//
//        return dictionary
//    }

}
