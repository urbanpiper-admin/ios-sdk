// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let feedbackConfig = try FeedbackConfig(json)

import Foundation

// MARK: - FeedbackConfig
@objc public class FeedbackConfig: NSObject, Codable, NSCoding {
    @objc public let choices: [Choice]
    @objc public let type: String

    init(choices: [Choice], type: String) {
        self.choices = choices
        self.type = type
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    public required init(coder aDecoder: NSCoder) {
        Choice.registerClass()
        choices = (aDecoder.decodeObject(forKey: "choices") as? [Choice])!
        type = (aDecoder.decodeObject(forKey: "type") as? String)!
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(FeedbackConfig.self, from: data)
        self.init(choices: me.choices, type: me.type)
    }
}

// MARK: FeedbackConfig convenience initializers and mutators

extension FeedbackConfig {

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
        choices: [Choice]? = nil,
        type: String? = nil
    ) -> FeedbackConfig {
        return FeedbackConfig(
            choices: choices ?? self.choices,
            type: type ?? self.type
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
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(choices, forKey: "choices")
        aCoder.encode(type, forKey: "type")
    }
}
