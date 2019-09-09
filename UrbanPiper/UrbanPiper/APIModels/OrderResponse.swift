//
//  OrderResponse.swift
//  UrbanPiper
//
//  Created by Vid on 09/02/19.
//

import UIKit

public class OrderResponse: NSObject, JSONDecodable {

    public var status: String?
    public var message: String?
    public var errorDetails: [String : AnyObject]?
    public var orderId: String?
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        status = dictionary["status"] as? String
        message = dictionary["message"] as? String
        errorDetails = dictionary["error_details"] as? [String : AnyObject]
        
        if let oid = dictionary["order_id"] as? String {
            orderId = oid
        } else if let oid = dictionary["order_id"] as? Int {
            orderId = "\(oid)"
        }
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject]
    {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        if let status = status {
            dictionary["status"] = status as AnyObject
        }
        if let message = message {
            dictionary["message"] = message as AnyObject
        }
        if let errorDetails = errorDetails {
            dictionary["error_details"] = errorDetails as AnyObject
        }
        if let orderId = orderId {
            dictionary["order_id"] = orderId as AnyObject
        }
        return dictionary
    }
    
}
