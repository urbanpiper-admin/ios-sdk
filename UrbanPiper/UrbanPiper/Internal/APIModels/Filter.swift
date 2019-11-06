// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let filter = try Filter(json)

import Foundation

// MARK: - Filter
@objc public class Filter: NSObject, Codable {
    @objc public let group: String
    @objc public let options: [FilterOption]

    init(group: String, options: [FilterOption]) {
        self.group = group
        self.options = options
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Filter.self, from: data)
        self.init(group: me.group, options: me.options)
    }
}

// MARK: Filter convenience initializers and mutators

extension Filter {

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
        group: String? = nil,
        options: [FilterOption]? = nil
    ) -> Filter {
        return Filter(
            group: group ?? self.group,
            options: options ?? self.options
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
