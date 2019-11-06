// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let storeResponse = try StoreResponse(json)

import Foundation

// MARK: - StoreResponse
@objc public class StoreResponse: NSObject, JSONDecodable, NSCoding {
    @objc public let biz: Biz
    @objc public let store: Store?

    init(biz: Biz, store: Store?) {
        self.biz = biz
        self.store = store
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(StoreResponse.self, from: data)
        self.init(biz: me.biz, store: me.store)
    }
    
    /**
         * NSCoding required initializer.
         * Fills the data from the passed decoder
         */
        public required init(coder aDecoder: NSCoder) {
            let biz = (aDecoder.decodeObject(forKey: "biz") as? Biz)!
    //      Remove this code after next release
            self.biz = biz.with(supportedLanguages: ["en"])

            Biz.shared = self.biz
            store = aDecoder.decodeObject(forKey: "store") as? Store
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
        return StoreResponse(
            biz: biz ?? self.biz,
            store: store ?? self.store
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    
        /**
         * NSCoding required method.
         * Encodes mode properties into the decoder
         */
        public func encode(with aCoder: NSCoder) {
            aCoder.encode(biz, forKey: "biz")
            aCoder.encode(store, forKey: "store")
        }
}
