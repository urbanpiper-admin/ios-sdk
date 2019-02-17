//
//	OrderDetails.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


@objc public class OrderDetails : NSObject{

	@objc public var details : PastOrder!
	@objc public var items : [Item]!
	public var nextState : AnyObject!
	public var nextStates : [String]!
	@objc public var payment : [OrderPayment]!
	public var statusUpdates : [StatusUpdate]!
	public var store : Store!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let detailsData = dictionary["details"] as? [String:Any]{
			details = PastOrder(fromDictionary: detailsData)
		}
		items = [Item]()
		if let itemsArray = dictionary["items"] as? [[String:Any]]{
			for dic in itemsArray{
				let value = Item(fromDictionary: dic)
				items.append(value)
			}
		}
		nextState = dictionary["next_state"] as AnyObject
		nextStates = dictionary["next_states"] as? [String]
		payment = [OrderPayment]()
		if let paymentArray = dictionary["payment"] as? [[String:Any]]{
			for dic in paymentArray{
				let value = OrderPayment(fromDictionary: dic)
				payment.append(value)
			}
		}
		statusUpdates = [StatusUpdate]()
		if let statusUpdatesArray = dictionary["status_updates"] as? [[String:Any]]{
			for dic in statusUpdatesArray{
				let value = StatusUpdate(fromDictionary: dic)
				statusUpdates.append(value)
			}
		}
		if let storeData = dictionary["store"] as? [String:Any]{
			store = Store(fromDictionary: storeData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	@objc public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if details != nil{
			dictionary["details"] = details.toDictionary()
		}
		if items != nil{
			var dictionaryElements = [[String:Any]]()
			for itemsElement in items {
				dictionaryElements.append(itemsElement.toDictionary())
			}
			dictionary["items"] = dictionaryElements
		}
		if nextState != nil{
			dictionary["next_state"] = nextState
		}
		if nextStates != nil{
			dictionary["next_states"] = nextStates
		}
		if payment != nil{
			var dictionaryElements = [[String:Any]]()
			for paymentElement in payment {
				dictionaryElements.append(paymentElement.toDictionary())
			}
			dictionary["payment"] = dictionaryElements
		}
		if statusUpdates != nil{
			var dictionaryElements = [[String:Any]]()
			for statusUpdatesElement in statusUpdates {
				dictionaryElements.append(statusUpdatesElement.toDictionary())
			}
			dictionary["status_updates"] = dictionaryElements
		}
		if store != nil{
			dictionary["store"] = store.toDictionary()
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
		if details != nil{
			aCoder.encode(details, forKey: "details")
		}
		if items != nil{
			aCoder.encode(items, forKey: "items")
		}
		if nextState != nil{
			aCoder.encode(nextState, forKey: "next_state")
		}
		if nextStates != nil{
			aCoder.encode(nextStates, forKey: "next_states")
		}
		if payment != nil{
			aCoder.encode(payment, forKey: "payment")
		}
		if statusUpdates != nil{
			aCoder.encode(statusUpdates, forKey: "status_updates")
		}
		if store != nil{
			aCoder.encode(store, forKey: "store")
		}

	}*/

}
