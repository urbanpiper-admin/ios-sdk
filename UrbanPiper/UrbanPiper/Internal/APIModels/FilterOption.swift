// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let filterOption = try FilterOption(json)

import Foundation

// MARK: - FilterOption
@objcMembers public class FilterOption: NSObject, Codable {
    public let id: Int
    public let title: String

    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(FilterOption.self, from: data)
        self.init(id: me.id, title: me.title)
    }

}

// MARK: Option convenience initializers and mutators

extension FilterOption {

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
        id: Int? = nil,
        title: String? = nil
    ) -> FilterOption {
        return FilterOption(
            id: id ?? self.id,
            title: title ?? self.title
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
