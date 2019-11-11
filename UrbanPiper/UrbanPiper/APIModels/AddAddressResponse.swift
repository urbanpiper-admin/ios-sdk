// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let addUpdateAddressResponse = try AddUpdateAddressResponse(json)

import Foundation

// MARK: - AddUpdateAddressResponse

@objcMembers public class AddUpdateAddressResponse: NSObject, JSONDecodable {
    public let addressid: Int
    public let msg: String

    enum CodingKeys: String, CodingKey {
        case addressid = "address_id"
        case msg
    }

    init(addressid: Int, msg: String) {
        self.addressid = addressid
        self.msg = msg
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(AddUpdateAddressResponse.self, from: data)
        self.init(addressid: me.addressid, msg: me.msg)
    }
}

// MARK: AddUpdateAddressResponse convenience initializers and mutators

extension AddUpdateAddressResponse {
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
        addressid: Int? = nil,
        msg: String? = nil
    ) -> AddUpdateAddressResponse {
        AddUpdateAddressResponse(
            addressid: addressid ?? self.addressid,
            msg: msg ?? self.msg
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
