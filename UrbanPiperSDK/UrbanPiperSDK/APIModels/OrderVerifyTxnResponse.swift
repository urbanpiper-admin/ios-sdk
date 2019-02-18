//
//  OrderVerifyTxnResponse.swift
//  UrbanPiperSDK
//
//  Created by Vid on 09/02/19.
//

import UIKit

public class OrderVerifyTxnResponse: NSObject {

    public var txnId: String?
    public var pid: String?
    public var status: String?
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    public init(fromDictionary dictionary:  [String:Any]){
        txnId = dictionary["txn_id"] as? String
        pid = dictionary["pid"] as? String
        status = dictionary["status"] as? String
    }

    @objc public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if txnId != nil{
            dictionary["txn_id"] = txnId
        }
        if pid != nil{
            dictionary["pid"] = pid
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }
}
