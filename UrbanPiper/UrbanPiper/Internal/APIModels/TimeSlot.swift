// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let timeSlot = try TimeSlot(json)

import Foundation

// MARK: - TimeSlot

@objcMembers public class TimeSlot: NSObject, Codable {
    public let day, endTime, startTime: String

    enum CodingKeys: String, CodingKey {
        case day
        case endTime = "end_time"
        case startTime = "start_time"
    }

    init(day: String, endTime: String, startTime: String) {
        self.day = day
        self.endTime = endTime
        self.startTime = startTime
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(TimeSlot.self, from: data)
        self.init(day: me.day, endTime: me.endTime, startTime: me.startTime)
    }
}

// MARK: TimeSlot convenience initializers and mutators

extension TimeSlot {
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
        day: String? = nil,
        endTime: String? = nil,
        startTime: String? = nil
    ) -> TimeSlot {
        TimeSlot(
            day: day ?? self.day,
            endTime: endTime ?? self.endTime,
            startTime: startTime ?? self.startTime
        )
    }

    func jsonData() throws -> Data {
        try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        String(data: try jsonData(), encoding: encoding)
    }

}
