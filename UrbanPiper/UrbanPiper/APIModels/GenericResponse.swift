// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let genericResponse = try GenericResponse(json)

import Foundation

// MARK: - GenericResponse

@objcMembers public class GenericResponse: NSObject, JSONDecodable {
    public let status: String?
    public let message: String?
    public let errorMessage: String?
    public let msg: String?

    enum CodingKeys: String, CodingKey {
        case status, message, msg
        case errorMessage = "error_message"
    }

    init(status: String? = "success", message: String? = nil, errorMessage: String? = nil, msg: String? = nil) {
        self.message = message
        self.status = status
        self.msg = msg
        self.errorMessage = errorMessage
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(GenericResponse.self, from: data)
        self.init(status: me.status, message: me.message, errorMessage: me.errorMessage, msg: me.msg)
    }
}

// MARK: GenericResponse convenience initializers and mutators

extension GenericResponse {
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
        status: String? = nil,
        msg: String? = nil,
        message: String? = nil,
        errorMessage: String? = nil
    ) -> GenericResponse {
        GenericResponse(
            status: status ?? self.status,
            message: message ?? self.message,
            errorMessage: errorMessage ?? self.errorMessage,
            msg: msg ?? self.msg
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }

    public func toObjcDictionary() -> [String: AnyObject] {
        toDictionary()
    }
}
