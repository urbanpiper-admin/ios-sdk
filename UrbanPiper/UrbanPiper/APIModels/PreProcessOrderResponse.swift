// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let preProcessOrderResponse = try PreProcessOrderResponse(json)

import Foundation

// MARK: - PreProcessOrderResponse

@objcMembers public class PreProcessOrderResponse: NSObject, JSONDecodable {
    public let order: Order

    init(order: Order) {
        self.order = order
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PreProcessOrderResponse.self, from: data)
        self.init(order: me.order)
    }
}

// MARK: PreProcessOrderResponse convenience initializers and mutators

extension PreProcessOrderResponse {
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
        order: Order? = nil
    ) -> PreProcessOrderResponse {
        PreProcessOrderResponse(
            order: order ?? self.order
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
