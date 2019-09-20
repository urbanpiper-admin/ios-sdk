//
//	VersionCheckResponse.swift
//
//	Create by Vidhyadharan Mohanram on 30/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class VersionCheckResponse: NSObject, JSONDecodable {
    public var forceUpdate: Bool
    public var latestVersion: String!
    public var releaseDate: Int?
    public var url: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        forceUpdate = dictionary["force_update"] as? Bool ?? false
        latestVersion = dictionary["latest_version"] as? String
        releaseDate = dictionary["release_date"] as? Int
        url = dictionary["url"] as? String
    }

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let forceUpdate = forceUpdate {
//            dictionary["force_update"] = forceUpdate as AnyObject
//        }
//        if let latestVersion = latestVersion {
//            dictionary["latest_version"] = latestVersion as AnyObject
//        }
//        if let releaseDate = releaseDate {
//            dictionary["release_date"] = releaseDate as AnyObject
//        }
//        if let url = url {
//            dictionary["url"] = url as AnyObject
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         forceUpdate = val as? Bool ?? false
//         latestVersion = aDecoder.decodeObject(forKey: "latest_version") as? String
//         releaseDate = aDecoder.decodeObject(forKey: "release_date") as? Int
//         url = aDecoder.decodeObject(forKey: "url") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let forceUpdate = forceUpdate {
//            aCoder.encode(forceUpdate, forKey: "force_update")
//        }
//        if let latestVersion = latestVersion {
//            aCoder.encode(latestVersion, forKey: "latest_version")
//        }
//        if let releaseDate = releaseDate {
//            aCoder.encode(releaseDate, forKey: "release_date")
//        }
//        if let url = url {
//            aCoder.encode(url, forKey: "url")
//        }
//
//    }
}
