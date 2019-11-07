// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let transaction = try Transaction(json)

import Foundation

// MARK: - Transaction
@objcMembers public class Transaction: NSObject, Codable {
    public let billNumber, comments: String?
    public let created: Date
    public let id: Int
    public let paymentAmount: Double
    public let paymentSrc, paymentType: String
    public let posMcid, posOperatorUname: JSONNull?
    public let store: Store?
    public let transactionid: String

    enum CodingKeys: String, CodingKey {
        case billNumber = "bill_number"
        case comments, created, id
        case paymentAmount = "payment_amount"
        case paymentSrc = "payment_src"
        case paymentType = "payment_type"
        case posMcid = "pos_mc_id"
        case posOperatorUname = "pos_operator_uname"
        case store
        case transactionid = "transaction_id"
    }

    init(billNumber: String?, comments: String?, created: Date, id: Int, paymentAmount: Double, paymentSrc: String, paymentType: String, posMcid: JSONNull?, posOperatorUname: JSONNull?, store: Store?, transactionid: String) {
        self.billNumber = billNumber
        self.comments = comments
        self.created = created
        self.id = id
        self.paymentAmount = paymentAmount
        self.paymentSrc = paymentSrc
        self.paymentType = paymentType
        self.posMcid = posMcid
        self.posOperatorUname = posOperatorUname
        self.store = store
        self.transactionid = transactionid
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Transaction.self, from: data)
        self.init(billNumber: me.billNumber, comments: me.comments, created: me.created, id: me.id, paymentAmount: me.paymentAmount, paymentSrc: me.paymentSrc, paymentType: me.paymentType, posMcid: me.posMcid, posOperatorUname: me.posOperatorUname, store: me.store, transactionid: me.transactionid)
    }
}

// MARK: Transaction convenience initializers and mutators

extension Transaction {

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
        billNumber: String? = nil,
        comments: String? = nil,
        created: Date? = nil,
        id: Int? = nil,
        paymentAmount: Double? = nil,
        paymentSrc: String? = nil,
        paymentType: String? = nil,
        posMcid: JSONNull? = nil,
        posOperatorUname: JSONNull? = nil,
        store: Store? = nil,
        transactionid: String? = nil
    ) -> Transaction {
        return Transaction(
            billNumber: billNumber ?? self.billNumber,
            comments: comments ?? self.comments,
            created: created ?? self.created,
            id: id ?? self.id,
            paymentAmount: paymentAmount ?? self.paymentAmount,
            paymentSrc: paymentSrc ?? self.paymentSrc,
            paymentType: paymentType ?? self.paymentType,
            posMcid: posMcid ?? self.posMcid,
            posOperatorUname: posOperatorUname ?? self.posOperatorUname,
            store: store ?? self.store,
            transactionid: transactionid ?? self.transactionid
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
