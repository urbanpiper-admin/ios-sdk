// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let storeListResponse = try StoreListResponse(json)

import Foundation

// MARK: - StoreLocatorResponse
@objc public class StoreListResponse: NSObject, JSONDecodable {
    @objc public let stores: [Store]

    init(stores: [Store]) {
        self.stores = stores
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(StoreListResponse.self, from: data)
        self.init(stores: me.stores)
    }
}

// MARK: StoreLocatorResponse convenience initializers and mutators

extension StoreListResponse {

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
        stores: [Store]? = nil
    ) -> StoreListResponse {
        return StoreListResponse(
            stores: stores ?? self.stores
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
