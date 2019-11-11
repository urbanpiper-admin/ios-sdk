// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let statusUpdate = try StatusUpdate(json)

import Foundation

// MARK: - StatusUpdate

@objcMembers public class StatusUpdate: NSObject, Codable {
    public let created: Int
    public let message, status, updatedBy: String

    enum CodingKeys: String, CodingKey {
        case created, message, status
        case updatedBy = "updated_by"
    }

    init(created: Int, message: String, status: String, updatedBy: String) {
        self.created = created
        self.message = message
        self.status = status
        self.updatedBy = updatedBy
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(StatusUpdate.self, from: data)
        self.init(created: me.created, message: me.message, status: me.status, updatedBy: me.updatedBy)
    }
}

// MARK: StatusUpdate convenience initializers and mutators

extension StatusUpdate {
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
        created: Int? = nil,
        message: String? = nil,
        status: String? = nil,
        updatedBy: String? = nil
    ) -> StatusUpdate {
        StatusUpdate(
            created: created ?? self.created,
            message: message ?? self.message,
            status: status ?? self.status,
            updatedBy: updatedBy ?? self.updatedBy
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
