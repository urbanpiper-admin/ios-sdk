//
//	WalletTransactionResponse.swift
//
//	Create by Vidhyadharan Mohanram on 29/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class WalletTransactionResponse : NSObject, JSONDecodable{

	public var meta : Meta!
	public var transactions : [Transaction]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		if let metaData: [String : AnyObject] = dictionary["meta"] as? [String : AnyObject]{
			meta = Meta(fromDictionary: metaData)
		}
		transactions = [Transaction]()
		if let transactionsArray: [[String : AnyObject]] = dictionary["transactions"] as? [[String : AnyObject]]{
			for dic in transactionsArray{
				guard let value: Transaction = Transaction(fromDictionary: dic) else { continue }
				transactions.append(value)
			}
		}
	}

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let meta = meta {
//            dictionary["meta"] = meta.toDictionary() as AnyObject
//        }
//        if let transactions = transactions {
//            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//            for transactionsElement in transactions {
//                dictionaryElements.append(transactionsElement.toDictionary())
//            }
//            dictionary["transactions"] = dictionaryElements as AnyObject
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
//        if let meta = meta {
//            aCoder.encode(meta, forKey: "meta")
//        }
//        if let transactions = transactions {
//            aCoder.encode(transactions, forKey: "transactions")
//        }
//
//    }

}
