//
//	GooglePlacesResponse.swift
//
//	Create by Vidhyadharan Mohanram on 10/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class GooglePlacesResponse : NSObject{

	public internal(set)  var predictions : [Prediction]!
	public private(set)  var status : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		predictions = [Prediction]()
		if let predictionsArray: [[String:Any]] = dictionary["predictions"] as? [[String:Any]]{
			for dic in predictionsArray{
				let value: Prediction = Prediction(fromDictionary: dic)
				predictions.append(value)
			}
		}
		status = dictionary["status"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if predictions != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for predictionsElement in predictions {
//                dictionaryElements.append(predictionsElement.toDictionary())
//            }
//            dictionary["predictions"] = dictionaryElements
//        }
//        if status != nil{
//            dictionary["status"] = status
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
//         predictions = aDecoder.decodeObject(forKey :"predictions") as? [Prediction]
//         status = aDecoder.decodeObject(forKey: "status") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if predictions != nil{
//            aCoder.encode(predictions, forKey: "predictions")
//        }
//        if status != nil{
//            aCoder.encode(status, forKey: "status")
//        }
//
//    }

}
