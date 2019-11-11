// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let feedbackConfig = try FeedbackConfig(json)

import Foundation

// MARK: - FeedbackConfig

@objcMembers public class FeedbackConfig: NSObject, Codable {
    public let choices: [Choice]
    public let type: String

    init(choices: [Choice], type: String) {
        self.choices = choices
        self.type = type
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
        FeedbackConfig(
            choices: choices ?? self.choices,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }

}
