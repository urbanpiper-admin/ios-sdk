// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let paymentInitResponse = try PaymentInitResponse(json)

import Foundation

// MARK: - PaymentInitResponse
@objc public class PaymentInitResponse: NSObject, JSONDecodable {
    @objc public let url: String?
    @objc public let message: String
    @objc public let data: DataClass
    @objc public let transactionid: String
    @objc public let success: Bool

    enum CodingKeys: String, CodingKey {
        case url, message, data
        case transactionid = "transaction_id"
        case success
    }

    init(url: String?, message: String, data: DataClass, transactionid: String, success: Bool) {
        self.url = url
        self.message = message
        self.data = data
        self.transactionid = transactionid
        self.success = success
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PaymentInitResponse.self, from: data)
        self.init(url: me.url, message: me.message, data: me.data, transactionid: me.transactionid, success: me.success)
    }
}

// MARK: PaymentInitResponse convenience initializers and mutators

extension PaymentInitResponse {

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
        url: String? = nil,
        message: String? = nil,
        data: DataClass? = nil,
        transactionid: String? = nil,
        success: Bool? = nil
    ) -> PaymentInitResponse {
        return PaymentInitResponse(
            url: url ?? self.url,
            message: message ?? self.message,
            data: data ?? self.data,
            transactionid: transactionid ?? self.transactionid,
            success: success ?? self.success
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
