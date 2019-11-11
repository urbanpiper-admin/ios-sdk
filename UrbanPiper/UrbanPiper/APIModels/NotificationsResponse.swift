// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let notificationsResponse = try NotificationsResponse(json)

import Foundation

// MARK: - NotificationsResponse

@objcMembers public class NotificationsResponse: NSObject, JSONDecodable {
    public let messages: [Message]
    public let meta: Meta

    init(messages: [Message], meta: Meta) {
        self.messages = messages
        self.meta = meta
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NotificationsResponse.self, from: data)
        self.init(messages: me.messages, meta: me.meta)
    }
}

// MARK: NotificationsResponse convenience initializers and mutators

extension NotificationsResponse {
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
        messages: [Message]? = nil,
        meta: Meta? = nil
    ) -> NotificationsResponse {
        NotificationsResponse(
            messages: messages ?? self.messages,
            meta: meta ?? self.meta
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
