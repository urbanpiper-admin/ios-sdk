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

public class OnlinePaymentData : NSObject{

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
	public init(fromDictionary dictionary:  [String:Any]){
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
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String:Any]
    {
        var dictionary: [String : Any] = [String:Any]()
        if key != nil{
            dictionary["key"] = key
        }
        if cALLBACKURL != nil{
            dictionary["CALLBACK_URL"] = cALLBACKURL
        }
        if cHANNELID != nil{
            dictionary["CHANNEL_ID"] = cHANNELID
        }
        if cHECKSUMHASH != nil{
            dictionary["CHECKSUMHASH"] = cHECKSUMHASH
        }
        if cUSTID != nil{
            dictionary["CUST_ID"] = cUSTID
        }
        if iNDUSTRYTYPEID != nil{
            dictionary["INDUSTRY_TYPE_ID"] = iNDUSTRYTYPEID
        }
        if mID != nil{
            dictionary["MID"] = mID
        }
        if oRDERID != nil{
            dictionary["ORDER_ID"] = oRDERID
        }
        if tXNAMOUNT != nil{
            dictionary["TXN_AMOUNT"] = tXNAMOUNT
        }
        if wEBSITE != nil{
            dictionary["WEBSITE"] = wEBSITE
        }
        if paymentUrl != nil{
            dictionary["payment_url"] = paymentUrl
        }
        if type != nil{
            dictionary["type"] = type
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
//        if key != nil{
//            aCoder.encode(key, forKey: "key")
//        }
//        if cALLBACKURL != nil{
//            aCoder.encode(cALLBACKURL, forKey: "CALLBACK_URL")
//        }
//        if cHANNELID != nil{
//            aCoder.encode(cHANNELID, forKey: "CHANNEL_ID")
//        }
//        if cHECKSUMHASH != nil{
//            aCoder.encode(cHECKSUMHASH, forKey: "CHECKSUMHASH")
//        }
//        if cUSTID != nil{
//            aCoder.encode(cUSTID, forKey: "CUST_ID")
//        }
//        if iNDUSTRYTYPEID != nil{
//            aCoder.encode(iNDUSTRYTYPEID, forKey: "INDUSTRY_TYPE_ID")
//        }
//        if mID != nil{
//            aCoder.encode(mID, forKey: "MID")
//        }
//        if oRDERID != nil{
//            aCoder.encode(oRDERID, forKey: "ORDER_ID")
//        }
//        if tXNAMOUNT != nil{
//            aCoder.encode(tXNAMOUNT, forKey: "TXN_AMOUNT")
//        }
//        if wEBSITE != nil{
//            aCoder.encode(wEBSITE, forKey: "WEBSITE")
//        }
//        if paymentUrl != nil{
//            aCoder.encode(paymentUrl, forKey: "payment_url")
//        }
//        if type != nil{
//            aCoder.encode(type, forKey: "type")
//        }
//
//    }

}
