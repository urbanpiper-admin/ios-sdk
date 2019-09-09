//
//	OnlinePaymentData.swift
//
//	Create by Vidhyadharan Mohanram on 1/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public enum PaymentType: String {
    case paytm = "paytm"
    case paytabs = "paytabs"
}

public class OnlinePaymentData : NSObject, JSONDecodable{

	public var cALLBACKURL : String!
	public var cHANNELID : String!
	public var cHECKSUMHASH : String!
	public var cUSTID : String!
	public var iNDUSTRYTYPEID : String!
	public var mID : String!
	public var oRDERID : String!
	public var tXNAMOUNT : String!
	public var wEBSITE : String!
	public var paymentUrl : String!
	public var type : String!
    public var key : String!
    
    public var paymentType: PaymentType {
        return PaymentType(rawValue: type)!
    }


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        key = dictionary["key"] as? String
		cALLBACKURL = dictionary["CALLBACK_URL"] as? String
		cHANNELID = dictionary["CHANNEL_ID"] as? String
		cHECKSUMHASH = dictionary["CHECKSUMHASH"] as? String
		cUSTID = dictionary["CUST_ID"] as? String
		iNDUSTRYTYPEID = dictionary["INDUSTRY_TYPE_ID"] as? String
		mID = dictionary["MID"] as? String
		oRDERID = dictionary["ORDER_ID"] as? String
		tXNAMOUNT = dictionary["TXN_AMOUNT"] as? String
		wEBSITE = dictionary["WEBSITE"] as? String
		paymentUrl = dictionary["payment_url"] as? String
		type = dictionary["type"] as? String
	}

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let key = key {
            dictionary["key"] = key as AnyObject
        }
        if let cALLBACKURL = cALLBACKURL {
            dictionary["CALLBACK_URL"] = cALLBACKURL as AnyObject
        }
        if let cHANNELID = cHANNELID {
            dictionary["CHANNEL_ID"] = cHANNELID as AnyObject
        }
        if let cHECKSUMHASH = cHECKSUMHASH {
            dictionary["CHECKSUMHASH"] = cHECKSUMHASH as AnyObject
        }
        if let cUSTID = cUSTID {
            dictionary["CUST_ID"] = cUSTID as AnyObject
        }
        if let iNDUSTRYTYPEID = iNDUSTRYTYPEID {
            dictionary["INDUSTRY_TYPE_ID"] = iNDUSTRYTYPEID as AnyObject
        }
        if let mID = mID {
            dictionary["MID"] = mID as AnyObject
        }
        if let oRDERID = oRDERID {
            dictionary["ORDER_ID"] = oRDERID as AnyObject
        }
        if let tXNAMOUNT = tXNAMOUNT {
            dictionary["TXN_AMOUNT"] = tXNAMOUNT as AnyObject
        }
        if let wEBSITE = wEBSITE {
            dictionary["WEBSITE"] = wEBSITE as AnyObject
        }
        if let paymentUrl = paymentUrl {
            dictionary["payment_url"] = paymentUrl as AnyObject
        }
        if let type = type {
            dictionary["type"] = type as AnyObject
        }
        return dictionary
    }

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//        key = aDecoder.decodeObject(forKey: "key") as? String
//         cALLBACKURL = aDecoder.decodeObject(forKey: "CALLBACK_URL") as? String
//         cHANNELID = aDecoder.decodeObject(forKey: "CHANNEL_ID") as? String
//         cHECKSUMHASH = aDecoder.decodeObject(forKey: "CHECKSUMHASH") as? String
//         cUSTID = aDecoder.decodeObject(forKey: "CUST_ID") as? String
//         iNDUSTRYTYPEID = aDecoder.decodeObject(forKey: "INDUSTRY_TYPE_ID") as? String
//         mID = aDecoder.decodeObject(forKey: "MID") as? String
//         oRDERID = aDecoder.decodeObject(forKey: "ORDER_ID") as? String
//         tXNAMOUNT = aDecoder.decodeObject(forKey: "TXN_AMOUNT") as? String
//         wEBSITE = aDecoder.decodeObject(forKey: "WEBSITE") as? String
//         paymentUrl = aDecoder.decodeObject(forKey: "payment_url") as? String
//         type = aDecoder.decodeObject(forKey: "type") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if let key = key {
//            aCoder.encode(key, forKey: "key")
//        }
//        if let cALLBACKURL = cALLBACKURL {
//            aCoder.encode(cALLBACKURL, forKey: "CALLBACK_URL")
//        }
//        if let cHANNELID = cHANNELID {
//            aCoder.encode(cHANNELID, forKey: "CHANNEL_ID")
//        }
//        if let cHECKSUMHASH = cHECKSUMHASH {
//            aCoder.encode(cHECKSUMHASH, forKey: "CHECKSUMHASH")
//        }
//        if let cUSTID = cUSTID {
//            aCoder.encode(cUSTID, forKey: "CUST_ID")
//        }
//        if let iNDUSTRYTYPEID = iNDUSTRYTYPEID {
//            aCoder.encode(iNDUSTRYTYPEID, forKey: "INDUSTRY_TYPE_ID")
//        }
//        if let mID = mID {
//            aCoder.encode(mID, forKey: "MID")
//        }
//        if let oRDERID = oRDERID {
//            aCoder.encode(oRDERID, forKey: "ORDER_ID")
//        }
//        if let tXNAMOUNT = tXNAMOUNT {
//            aCoder.encode(tXNAMOUNT, forKey: "TXN_AMOUNT")
//        }
//        if let wEBSITE = wEBSITE {
//            aCoder.encode(wEBSITE, forKey: "WEBSITE")
//        }
//        if let paymentUrl = paymentUrl {
//            aCoder.encode(paymentUrl, forKey: "payment_url")
//        }
//        if let type = type {
//            aCoder.encode(type, forKey: "type")
//        }
//
//    }

}
