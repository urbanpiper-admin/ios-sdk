// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let storeResponse = try StoreResponse(json)

import Foundation

// MARK: - StoreResponse

@objcMembers public class StoreResponse: NSObject, JSONDecodable {
    public let biz: Biz
    public let store: Store?

    init(biz: Biz, store: Store?) {
        self.biz = biz
        self.store = store
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(StoreResponse.self, from: data)
        self.init(biz: me.biz, store: me.store)
    }
}

// MARK: StoreResponse convenience initializers and mutators

extension StoreResponse {
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
        biz: Biz? = nil,
        store: Store? = nil
    ) -> StoreResponse {
        StoreResponse(
            biz: biz ?? self.biz,
            store: store ?? self.store
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
    
}
