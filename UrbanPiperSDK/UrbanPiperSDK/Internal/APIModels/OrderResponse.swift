//
//  OrderResponse.swift
//  UrbanPiperSDK
//
//  Created by Vid on 09/02/19.
//

import UIKit

public class OrderResponse: NSObject {

    public private(set)  var status: String?
    public private(set)  var message: String?
    public private(set)  var errorDetails: [String: Any]?
    public private(set)  var orderId: String?
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal init(fromDictionary dictionary:  [String:Any]){
        status = dictionary["status"] as? String
        message = dictionary["message"] as? String
        errorDetails = dictionary["error_details"] as? [String: Any]
        
        if let oid = dictionary["order_id"] as? String {
            orderId = oid
        } else if let oid = dictionary["order_id"] as? Int {
            orderId = "\(oid)"
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if status != nil{
            dictionary["status"] = status
        }
        if message != nil{
            dictionary["message"] = message
        }
        if errorDetails != nil{
            dictionary["error_details"] = status
        }
        if orderId != nil{
            dictionary["order_id"] = orderId
        }
        return dictionary
    }
    
}
