// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let customer = try Customer(json)

import Foundation

// MARK: - Customer
@objcMembers public class Customer: NSObject, Codable {
    public let address: Address
    public let email, name, phone: String

    init(address: Address, email: String, name: String, phone: String) {
        self.address = address
        self.email = email
        self.name = name
        self.phone = phone
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Customer.self, from: data)
        self.init(address: me.address, email: me.email, name: me.name, phone: me.phone)
    }

}

// MARK: Customer convenience initializers and mutators

extension Customer {

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
        address: Address? = nil,
        email: String? = nil,
        name: String? = nil,
        phone: String? = nil
    ) -> Customer {
        return Customer(
            address: address ?? self.address,
            email: email ?? self.email,
            name: name ?? self.name,
            phone: phone ?? self.phone
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
