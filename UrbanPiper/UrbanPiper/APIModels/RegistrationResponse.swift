// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let registrationResponse = try RegistrationResponse(json)

import Foundation

// MARK: - RegistrationResponse
@objcMembers public class RegistrationResponse: NSObject, JSONDecodable {
    public let accessToken, activeOtp, approvalCode, authKey: String
    public let cardNumber, customerEmail, customerName, customerPhone: String
    public let message: String
    public let points, prepaidBalance: Int
    public let result: String
    public let success: Bool
    public let timestamp: String
    public let totalBalance: Int
    public let token: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case activeOtp = "active_otp"
        case approvalCode = "approval_code"
        case authKey = "auth_key"
        case cardNumber = "card_number"
        case customerEmail = "customer_email"
        case customerName = "customer_name"
        case customerPhone = "customer_phone"
        case message, points
        case prepaidBalance = "prepaid_balance"
        case result, success, timestamp
        case totalBalance = "total_balance"
        case token
    }

    init(accessToken: String, activeOtp: String, approvalCode: String, authKey: String, cardNumber: String, customerEmail: String, customerName: String, customerPhone: String, message: String, points: Int, prepaidBalance: Int, result: String, success: Bool, timestamp: String, totalBalance: Int, token: String?) {
        self.accessToken = accessToken
        self.activeOtp = activeOtp
        self.approvalCode = approvalCode
        self.authKey = authKey
        self.cardNumber = cardNumber
        self.customerEmail = customerEmail
        self.customerName = customerName
        self.customerPhone = customerPhone
        self.message = message
        self.points = points
        self.prepaidBalance = prepaidBalance
        self.result = result
        self.success = success
        self.timestamp = timestamp
        self.totalBalance = totalBalance
        self.token = token
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(RegistrationResponse.self, from: data)
        self.init(accessToken: me.accessToken, activeOtp: me.activeOtp, approvalCode: me.approvalCode, authKey: me.authKey, cardNumber: me.cardNumber, customerEmail: me.customerEmail, customerName: me.customerName, customerPhone: me.customerPhone, message: me.message, points: me.points, prepaidBalance: me.prepaidBalance, result: me.result, success: me.success, timestamp: me.timestamp, totalBalance: me.totalBalance, token: me.token)
    }
}

// MARK: RegistrationResponse convenience initializers and mutators

extension RegistrationResponse {

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
        accessToken: String? = nil,
        activeOtp: String? = nil,
        approvalCode: String? = nil,
        authKey: String? = nil,
        cardNumber: String? = nil,
        customerEmail: String? = nil,
        customerName: String? = nil,
        customerPhone: String? = nil,
        message: String? = nil,
        points: Int? = nil,
        prepaidBalance: Int? = nil,
        result: String? = nil,
        success: Bool? = nil,
        timestamp: String? = nil,
        totalBalance: Int? = nil,
        token: String? = nil
    ) -> RegistrationResponse {
        return RegistrationResponse(
            accessToken: accessToken ?? self.accessToken,
            activeOtp: activeOtp ?? self.activeOtp,
            approvalCode: approvalCode ?? self.approvalCode,
            authKey: authKey ?? self.authKey,
            cardNumber: cardNumber ?? self.cardNumber,
            customerEmail: customerEmail ?? self.customerEmail,
            customerName: customerName ?? self.customerName,
            customerPhone: customerPhone ?? self.customerPhone,
            message: message ?? self.message,
            points: points ?? self.points,
            prepaidBalance: prepaidBalance ?? self.prepaidBalance,
            result: result ?? self.result,
            success: success ?? self.success,
            timestamp: timestamp ?? self.timestamp,
            totalBalance: totalBalance ?? self.totalBalance,
            token: token ?? self.token
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
