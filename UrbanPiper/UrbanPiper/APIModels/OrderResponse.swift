// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let orderResponse = try OrderResponse(json)

import Foundation

// MARK: - OrderResponse

@objcMembers public class OrderResponse: NSObject, JSONDecodable {
    public let message: String?
    public let errorDetails: String?
    public let orderid: Int
    public let status: String

    enum CodingKeys: String, CodingKey {
        case message
        case orderid = "order_id"
        case status
        case errorDetails = "error_details"
    }

    init(message: String?, orderid: Int, status: String, errorDetails: String?) {
        self.message = message
        self.orderid = orderid
        self.status = status
        self.errorDetails = errorDetails
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OrderResponse.self, from: data)
        self.init(message: me.message, orderid: me.orderid, status: me.status, errorDetails: me.errorDetails)
    }
}

// MARK: OrderResponse convenience initializers and mutators

extension OrderResponse {
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
        message: String? = nil,
        orderid: Int? = nil,
        status: String? = nil,
        errorDetails: String? = nil
    ) -> OrderResponse {
        OrderResponse(
            message: message ?? self.message,
            orderid: orderid ?? self.orderid,
            status: status ?? self.status,
            errorDetails: errorDetails ?? self.errorDetails
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
