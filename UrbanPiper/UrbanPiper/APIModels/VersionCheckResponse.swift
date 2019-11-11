// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let versionCheckResponse = try VersionCheckResponse(json)

import Foundation

// MARK: - VersionCheckResponse

@objcMembers public class VersionCheckResponse: NSObject, JSONDecodable {
    public let forceUpdate: Bool
    public let latestVersion: String
    public let releaseDate: Date?
    public let url: String?

    enum CodingKeys: String, CodingKey {
        case forceUpdate = "force_update"
        case latestVersion = "latest_version"
        case releaseDate = "release_date"
        case url
    }

    init(forceUpdate: Bool, latestVersion: String, releaseDate: Date?, url: String?) {
        self.forceUpdate = forceUpdate
        self.latestVersion = latestVersion
        self.releaseDate = releaseDate
        self.url = url
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(VersionCheckResponse.self, from: data)
        self.init(forceUpdate: me.forceUpdate, latestVersion: me.latestVersion, releaseDate: me.releaseDate, url: me.url)
    }
}

// MARK: VersionCheckResponse convenience initializers and mutators

extension VersionCheckResponse {
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
        forceUpdate: Bool? = nil,
        latestVersion: String? = nil,
        releaseDate: Date? = nil,
        url: String? = nil
    ) -> VersionCheckResponse {
        VersionCheckResponse(
            forceUpdate: forceUpdate ?? self.forceUpdate,
            latestVersion: latestVersion ?? self.latestVersion,
            releaseDate: releaseDate ?? self.releaseDate,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }
}
