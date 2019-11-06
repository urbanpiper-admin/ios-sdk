// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let walletTransactionResponse = try WalletTransactionResponse(json)

import Foundation

// MARK: - WalletTransactionResponse
@objc public class WalletTransactionResponse: NSObject, JSONDecodable {
    @objc public let meta: Meta
    @objc public let transactions: [Transaction]

    init(meta: Meta, transactions: [Transaction]) {
        self.meta = meta
        self.transactions = transactions
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(WalletTransactionResponse.self, from: data)
        self.init(meta: me.meta, transactions: me.transactions)
    }
}

// MARK: WalletTransactionResponse convenience initializers and mutators

extension WalletTransactionResponse {

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
        transactions: [Transaction]? = nil
    ) -> WalletTransactionResponse {
        return WalletTransactionResponse(
            meta: meta ?? self.meta,
            transactions: transactions ?? self.transactions
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
