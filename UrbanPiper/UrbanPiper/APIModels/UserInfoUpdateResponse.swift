// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let userInfoUpdateResponse = try UserInfoUpdateResponse(json)

import Foundation

// MARK: - UserInfoUpdateResponse
@objc public class UserInfoUpdateResponse: NSObject, JSONDecodable {
    @objc public let success: Bool
    @objc public let msg: String?

    init(msg: String?, success: Bool) {
        self.msg = msg
        self.success = success
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(UserInfoUpdateResponse.self, from: data)
        self.init(msg: me.msg, success: me.success)
    }
}

// MARK: UserInfoUpdateResponse convenience initializers and mutators

extension UserInfoUpdateResponse {

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
        success: Bool? = nil,
        msg: String? = nil
    ) -> UserInfoUpdateResponse {
        return UserInfoUpdateResponse(
            msg: msg ?? self.msg,
            success: success ?? self.success
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    @objc public func toObjcDictionary() -> [String : AnyObject] {
        return toDictionary()
    }
}
