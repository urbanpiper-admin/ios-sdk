//
//  OrderVerifyTxnResponse.swift
//  UrbanPiper
//
//  Created by Vid on 09/02/19.
//

import UIKit

public class OrderVerifyTxnResponse: NSObject, JSONDecodable {
    public var txnId: String?
    public var pid: String?
    public var status: String?

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        txnId = dictionary["txn_id"] as? String
        pid = dictionary["pid"] as? String
        status = dictionary["status"] as? String
    }

    @objc public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        if let txnId = txnId {
            dictionary["txn_id"] = txnId as AnyObject
        }
        if let pid = pid {
            dictionary["pid"] = pid as AnyObject
        }
        if let status = status {
            dictionary["status"] = status as AnyObject
        }
        return dictionary
    }
}
