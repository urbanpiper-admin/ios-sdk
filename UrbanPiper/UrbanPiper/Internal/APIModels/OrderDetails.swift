//
//	OrderDetails.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

@objc public class OrderDetails: NSObject, JSONDecodable {
    @objc public var details: PastOrder!
    @objc public var items: [PastOrderItem]!
    public var nextState: AnyObject!
    public var nextStates: [String]!
    @objc public var payment: [OrderPayment]!
    public var statusUpdates: [StatusUpdate]!
    public var store: Store!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        if let detailsData = dictionary["details"] as? [String: AnyObject] {
            details = PastOrder(fromDictionary: detailsData)
        }
        items = [PastOrderItem]()
        if let itemsArray = dictionary["items"] as? [[String: AnyObject]] {
            for dic in itemsArray {
                guard let value = PastOrderItem(fromDictionary: dic) else { continue }
                items.append(value)
            }
        }
        nextState = dictionary["next_state"] as AnyObject
        nextStates = dictionary["next_states"] as? [String]
        payment = [OrderPayment]()
        if let paymentArray = dictionary["payment"] as? [[String: AnyObject]] {
            for dic in paymentArray {
                guard let value = OrderPayment(fromDictionary: dic) else { continue }
                payment.append(value)
            }
        }
        statusUpdates = [StatusUpdate]()
        if let statusUpdatesArray = dictionary["status_updates"] as? [[String: AnyObject]] {
            for dic in statusUpdatesArray {
                guard let value = StatusUpdate(fromDictionary: dic) else { continue }
                statusUpdates.append(value)
            }
        }
        if let storeData = dictionary["store"] as? [String: AnyObject] {
            store = Store(fromDictionary: storeData)
        }
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        if let details = details {
            dictionary["details"] = details.toDictionary() as AnyObject
        }
        if let items = items {
            var dictionaryElements = [[String: AnyObject]]()
            for itemsElement in items {
                dictionaryElements.append(itemsElement.toDictionary())
            }
            dictionary["items"] = dictionaryElements as AnyObject
        }
        if let nextState = nextState {
            dictionary["next_state"] = nextState as AnyObject
        }
        if let nextStates = nextStates {
            dictionary["next_states"] = nextStates as AnyObject
        }
        if let payment = payment {
            var dictionaryElements = [[String: AnyObject]]()
            for paymentElement in payment {
                dictionaryElements.append(paymentElement.toDictionary())
            }
            dictionary["payment"] = dictionaryElements as AnyObject
        }
        if let statusUpdates = statusUpdates {
            var dictionaryElements = [[String: AnyObject]]()
            for statusUpdatesElement in statusUpdates {
                dictionaryElements.append(statusUpdatesElement.toDictionary())
            }
            dictionary["status_updates"] = dictionaryElements as AnyObject
        }
        if let store = store {
            dictionary["store"] = store.toDictionary() as AnyObject
        }
        return dictionary
    }

    /*    /**
      * NSCoding required initializer.
      * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
    details = aDecoder.decodeObject(forKey: "details") as? Detail
    items = aDecoder.decodeObject(forKey :"items") as? [Item]
    nextState = aDecoder.decodeObject(forKey: "next_state") as? AnyObject
    nextStates = aDecoder.decodeObject(forKey: "next_states") as? [String]
    payment = aDecoder.decodeObject(forKey :"payment") as? [Payment]
    statusUpdates = aDecoder.decodeObject(forKey :"status_updates") as? [StatusUpdate]
    store = aDecoder.decodeObject(forKey: "store") as? Store

    }

    /**
      * NSCoding required method.
      * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
    	if let details = details {
    		aCoder.encode(details, forKey: "details")
    	}
    	if let items = items {
    		aCoder.encode(items, forKey: "items")
    	}
    	if let nextState = nextState {
    		aCoder.encode(nextState, forKey: "next_state")
    	}
    	if let nextStates = nextStates {
    		aCoder.encode(nextStates, forKey: "next_states")
    	}
    	if let payment = payment {
    		aCoder.encode(payment, forKey: "payment")
    	}
    	if let statusUpdates = statusUpdates {
    		aCoder.encode(statusUpdates, forKey: "status_updates")
    	}
    	if let store = store {
    		aCoder.encode(store, forKey: "store")
    	}

    }*/
}
