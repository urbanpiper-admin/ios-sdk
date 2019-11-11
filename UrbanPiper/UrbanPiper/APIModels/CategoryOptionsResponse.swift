// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let categoryOptionsResponse = try CategoryOptionsResponse(json)

import Foundation

// MARK: - CategoryOptionsResponse

@objcMembers public class CategoryOptionsResponse: NSObject, JSONDecodable {
    public let filters: [Filter]
    public let sortBy: [String]

    enum CodingKeys: String, CodingKey {
        case filters
        case sortBy = "sort_by"
    }

    init(filters: [Filter], sortBy: [String]) {
        self.filters = filters
        self.sortBy = sortBy
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(CategoryOptionsResponse.self, from: data)
        self.init(filters: me.filters, sortBy: me.sortBy)
    }
}

// MARK: CategoryOptionsResponse convenience initializers and mutators

extension CategoryOptionsResponse {
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
        filters: [Filter]? = nil,
        sortBy: [String]? = nil
    ) -> CategoryOptionsResponse {
        CategoryOptionsResponse(
            filters: filters ?? self.filters,
            sortBy: sortBy ?? self.sortBy
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
