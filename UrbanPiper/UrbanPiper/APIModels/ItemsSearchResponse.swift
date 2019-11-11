//
//	ItemsSearchResponse.swift
//
//	Create by Vidhyadharan Mohanram on 12/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

@objcMembers public class ItemsSearchResponse: NSObject, JSONDecodable {
    public let meta: Meta
    public let items: [Item]

    init(meta: Meta, items: [Item]) {
        self.meta = meta
        self.items = items
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ItemsSearchResponse.self, from: data)
        self.init(meta: me.meta, items: me.items)
    }
}

// MARK: CategoryItemsResponse convenience initializers and mutators

extension ItemsSearchResponse {
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
        items: [Item]? = nil
    ) -> ItemsSearchResponse {
        ItemsSearchResponse(
            meta: meta ?? self.meta,
            items: items ?? self.items
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
