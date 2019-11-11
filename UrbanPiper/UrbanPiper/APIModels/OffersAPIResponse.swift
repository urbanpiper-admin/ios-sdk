// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let offersAPIResponse = try OffersAPIResponse(json)

import Foundation

// MARK: - OffersAPIResponse

@objcMembers public class OffersAPIResponse: NSObject, JSONDecodable {
    public let coupons: [Coupon]
    public let meta: Meta

    init(coupons: [Coupon], meta: Meta) {
        self.coupons = coupons
        self.meta = meta
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OffersAPIResponse.self, from: data)
        self.init(coupons: me.coupons, meta: me.meta)
    }
}

// MARK: OffersAPIResponse convenience initializers and mutators

extension OffersAPIResponse {
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
        coupons: [Coupon]? = nil,
        meta: Meta? = nil
    ) -> OffersAPIResponse {
        OffersAPIResponse(
            coupons: coupons ?? self.coupons,
            meta: meta ?? self.meta
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
