// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let timeSlot = try TimeSlot(json)

import Foundation

// MARK: - TimeSlot
@objc public class TimeSlot: NSObject, Codable, NSCoding {
    @objc public let day, endTime, startTime: String

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
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    public required init(coder aDecoder: NSCoder) {
        day = (aDecoder.decodeObject(forKey: "day") as? String)!
        endTime = (aDecoder.decodeObject(forKey: "end_time") as? String)!
        startTime = (aDecoder.decodeObject(forKey: "start_time") as? String)!
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
        return TimeSlot(
            day: day ?? self.day,
            endTime: endTime ?? self.endTime,
            startTime: startTime ?? self.startTime
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
        aCoder.encode(day, forKey: "day")
        aCoder.encode(endTime, forKey: "end_time")
        aCoder.encode(startTime, forKey: "start_time")
    }
}
