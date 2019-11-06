// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pastOrdersResponse = try PastOrdersResponse(json)

import Foundation

// MARK: - PastOrdersResponse
@objc public class PastOrdersResponse: NSObject, JSONDecodable {
    @objc public let meta: Meta
    @objc public let orders: [PastOrder]

    init(meta: Meta, orders: [PastOrder]) {
        self.meta = meta
        self.orders = orders
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PastOrdersResponse.self, from: data)
        self.init(meta: me.meta, orders: me.orders)
    }
}

// MARK: PastOrdersResponse convenience initializers and mutators

extension PastOrdersResponse {

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
        meta: Meta? = nil,
        orders: [PastOrder]? = nil
    ) -> PastOrdersResponse {
        return PastOrdersResponse(
            meta: meta ?? self.meta,
            orders: orders ?? self.orders
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
