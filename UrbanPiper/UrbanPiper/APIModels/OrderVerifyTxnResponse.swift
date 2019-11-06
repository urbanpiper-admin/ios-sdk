// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let orderVerifyTxnResponse = try OrderVerifyTxnResponse(json)

import Foundation

// MARK: - OrderVerifyTxnResponse
@objc public class OrderVerifyTxnResponse: NSObject, JSONDecodable {
    @objc public let txnId: String?
    @objc public let pid: String?
    @objc public let status: String?

    enum CodingKeys: String, CodingKey {
        case txnId = "txn_id"
        case pid, status
    }

    init(txnId: String?, pid: String?, status: String?) {
        self.txnId = txnId
        self.pid = pid
        self.status = status
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OrderVerifyTxnResponse.self, from: data)
        self.init(txnId: me.txnId, pid: me.pid, status: me.status)
    }
}

// MARK: OrderVerifyTxnResponse convenience initializers and mutators

extension OrderVerifyTxnResponse {

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
        txnId: String? = nil,
        pid: String? = nil,
        status: String? = nil
    ) -> OrderVerifyTxnResponse {
        return OrderVerifyTxnResponse(
            txnId: txnId ?? self.txnId,
            pid: pid ?? self.pid,
            status: status ?? self.status
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
