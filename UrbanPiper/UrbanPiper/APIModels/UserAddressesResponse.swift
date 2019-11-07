// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let userAddressesResponse = try UserAddressesResponse(json)

import Foundation

// MARK: - UserAddressesResponse
@objcMembers public class UserAddressesResponse: NSObject, JSONDecodable {
    public let addresses: [Address]

    init(addresses: [Address]) {
        self.addresses = addresses
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(UserAddressesResponse.self, from: data)
        self.init(addresses: me.addresses)
    }
}

// MARK: UserAddressesResponse convenience initializers and mutators

extension UserAddressesResponse {

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
        addresses: [Address]? = nil
    ) -> UserAddressesResponse {
        return UserAddressesResponse(
            addresses: addresses ?? self.addresses
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    public func toObjcDictionary() -> [String : AnyObject] {
        return toDictionary()
    }
}
