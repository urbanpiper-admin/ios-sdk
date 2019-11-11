// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let pastOrderDetailsResponse = try PastOrderDetailsResponse(json)

import Foundation

// MARK: - PastOrderDetailsResponse

@objcMembers public class PastOrderDetailsResponse: NSObject, JSONDecodable {
    public let customer: Customer
    public let order: OrderDetails

    init(customer: Customer, order: OrderDetails) {
        self.customer = customer
        self.order = order
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PastOrderDetailsResponse.self, from: data)
        self.init(customer: me.customer, order: me.order)
    }
}

// MARK: PastOrderDetailsResponse convenience initializers and mutators

extension PastOrderDetailsResponse {
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
        customer: Customer? = nil,
        order: OrderDetails? = nil
    ) -> PastOrderDetailsResponse {
        PastOrderDetailsResponse(
            customer: customer ?? self.customer,
            order: order ?? self.order
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
