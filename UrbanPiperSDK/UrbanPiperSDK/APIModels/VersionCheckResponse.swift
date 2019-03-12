//
//	VersionCheckResponse.swift
//
//	Create by Vidhyadharan Mohanram on 30/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class VersionCheckResponse : NSObject{

    public private(set) var forceUpdate : Bool!
	public private(set) var latestVersion : String!
	public private(set) var releaseDate : Int!
	public private(set) var url : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		forceUpdate = dictionary["force_update"] as? Bool
		latestVersion = dictionary["latest_version"] as? String
		releaseDate = dictionary["release_date"] as? Int
		url = dictionary["url"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if forceUpdate != nil{
//            dictionary["force_update"] = forceUpdate
//        }
//        if latestVersion != nil{
//            dictionary["latest_version"] = latestVersion
//        }
//        if releaseDate != nil{
//            dictionary["release_date"] = releaseDate
//        }
//        if url != nil{
//            dictionary["url"] = url
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
//         forceUpdate = aDecoder.decodeObject(forKey: "force_update") as? Bool
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
//        if forceUpdate != nil{
//            aCoder.encode(forceUpdate, forKey: "force_update")
//        }
//        if latestVersion != nil{
//            aCoder.encode(latestVersion, forKey: "latest_version")
//        }
//        if releaseDate != nil{
//            aCoder.encode(releaseDate, forKey: "release_date")
//        }
//        if url != nil{
//            aCoder.encode(url, forKey: "url")
//        }
//
//    }

}
