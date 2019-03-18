//
//	WalletTransactionResponse.swift
//
//	Create by Vidhyadharan Mohanram on 29/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class WalletTransactionResponse : NSObject{

	public var meta : Meta!
	public var transactions : [Transaction]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let metaData: [String:Any] = dictionary["meta"] as? [String:Any]{
			meta = Meta(fromDictionary: metaData)
		}
		transactions = [Transaction]()
		if let transactionsArray: [[String:Any]] = dictionary["transactions"] as? [[String:Any]]{
			for dic in transactionsArray{
				let value: Transaction = Transaction(fromDictionary: dic)
				transactions.append(value)
			}
		}
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if meta != nil{
//            dictionary["meta"] = meta.toDictionary()
//        }
//        if transactions != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for transactionsElement in transactions {
//                dictionaryElements.append(transactionsElement.toDictionary())
//            }
//            dictionary["transactions"] = dictionaryElements
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
//         meta = aDecoder.decodeObject(forKey: "meta") as? Meta
//         transactions = aDecoder.decodeObject(forKey :"transactions") as? [Transaction]
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if meta != nil{
//            aCoder.encode(meta, forKey: "meta")
//        }
//        if transactions != nil{
//            aCoder.encode(transactions, forKey: "transactions")
//        }
//
//    }

}
