// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   @objc public let userBizInfoResponse = try UserBizInfoResponse(json)

import Foundation

// MARK: - UserBizInfoResponse
@objc public class UserBizInfoResponse: NSObject, JSONDecodable, NSCoding {
    @objc public let meta: Meta
    @objc public let userBizInfos: [UserBizInfo]

    enum CodingKeys: String, CodingKey {
        case meta
        case userBizInfos = "objects"
    }
    
    init(meta: Meta, userBizInfos: [UserBizInfo]) {
        self.meta = meta
        self.userBizInfos = userBizInfos
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(UserBizInfoResponse.self, from: data)
        self.init(meta: me.meta, userBizInfos: me.userBizInfos)
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    public required init(coder aDecoder: NSCoder) {
        meta = (aDecoder.decodeObject(forKey: "meta") as? Meta)!
        userBizInfos = (aDecoder.decodeObject(forKey: "objects") as? [UserBizInfo])!
    }
}

// MARK: UserBizInfoResponse convenience initializers and mutators

extension UserBizInfoResponse {

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
        userBizInfos: [UserBizInfo]? = nil
    ) -> UserBizInfoResponse {
        return UserBizInfoResponse(
            meta: meta ?? self.meta,
            userBizInfos: userBizInfos ?? self.userBizInfos
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    // public func toDictionary() -> [String: AnyObject] {
//        var dictionary: [String: AnyObject] = [String: AnyObject]()
//        dictionary["meta"] = meta.toDictionary() as AnyObject
//        
//        var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
//        for userBizInfo in userBizInfos {
//            dictionaryElements.append(userBizInfo.toDictionary())
//        }
//        dictionary["objects"] = dictionaryElements as AnyObject
//        
//        return dictionary
//    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(meta, forKey: "meta")
        aCoder.encode(userBizInfos, forKey: "objects")
    }
}
