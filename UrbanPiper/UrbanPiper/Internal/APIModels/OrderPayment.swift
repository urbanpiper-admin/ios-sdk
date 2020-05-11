// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let orderPayment = try OrderPayment(json)

import Foundation

// MARK: - OrderPayment

@objcMembers public class OrderPayment: NSObject, Codable {
    public let amount: Double
    public let option: String
    public let srvrTrxid: String?

    enum CodingKeys: String, CodingKey {
        case amount, option
        case srvrTrxid = "srvr_trx_id"
    }

    init(amount: Double, option: String, srvrTrxid: String?) {
        self.amount = amount
        self.option = option
        self.srvrTrxid = srvrTrxid
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OrderPayment.self, from: data)
        self.init(amount: me.amount, option: me.option, srvrTrxid: me.srvrTrxid)
    }
}

// MARK: OrderPayment convenience initializers and mutators

extension OrderPayment {
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
        amount: Double? = nil,
        option: String? = nil,
        srvrTrxid: String? = nil
    ) -> OrderPayment {
        OrderPayment(
            amount: amount ?? self.amount,
            option: option ?? self.option,
            srvrTrxid: srvrTrxid ?? self.srvrTrxid
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
