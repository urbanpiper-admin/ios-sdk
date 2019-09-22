//
//	StoreResponse.swift
//
//	Create by Vidhyadharan Mohanram on 29/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

@objc public class StoreResponse: NSObject, JSONDecodable, NSCoding {
    @objc public var biz: Biz!
    @objc public var store: Store?
    
    public convenience init(biz: Biz, store: Store?) {
        self.init(fromDictionary: [:])!
        
        self.biz = biz
        self.store = store
    }

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        if let bizData: [String: AnyObject] = dictionary["biz"] as? [String: AnyObject] {
            biz = Biz(fromDictionary: bizData)
        }

        Biz.shared = biz

        if let storeData: [String: AnyObject] = dictionary["store"] as? [String: AnyObject] {
            store = Store(fromDictionary: storeData)
        }
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        if let biz = biz {
            dictionary["biz"] = biz.toDictionary() as AnyObject
        }
        if let store = store {
            dictionary["store"] = store.toDictionary() as AnyObject
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        Biz.registerClass()
        Store.registerClass()
        biz = aDecoder.decodeObject(forKey: "biz") as? Biz

//      Remove this code after next release
        biz.supportedLanguages = ["en"]

        Biz.shared = biz
        store = aDecoder.decodeObject(forKey: "store") as? Store
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if let biz = biz {
            aCoder.encode(biz, forKey: "biz")
        }
        if let store = store {
            aCoder.encode(store, forKey: "store")
        }
    }
}
