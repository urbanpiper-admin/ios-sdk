//
//  OrderVerifyTxnResponse.swift
//  UrbanPiper
//
//  Created by Vid on 09/02/19.
//

import UIKit

public class OrderVerifyTxnResponse: NSObject {

    public private(set) var txnId: String?
    public private(set) var pid: String?
    public private(set) var status: String?
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal init(fromDictionary dictionary:  [String:Any]){
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
