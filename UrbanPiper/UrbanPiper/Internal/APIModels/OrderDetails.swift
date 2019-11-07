// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let order = try Order(json)

import Foundation

// MARK: - OrderDetails
@objcMembers public class OrderDetails: NSObject, Codable {
    public let details: PastOrderDetails
    public let items: [PastOrderItem]
    public let nextState: String?
    public let nextStates: [String]
    public let payment: [OrderPayment]
    public let statusUpdates: [StatusUpdate]
    public let store: PastOrderStore

    enum CodingKeys: String, CodingKey {
        case details, items
        case nextState = "next_state"
        case nextStates = "next_states"
        case payment
        case statusUpdates = "status_updates"
        case store
    }

    init(details: PastOrderDetails, items: [PastOrderItem], nextState: String?, nextStates: [String], payment: [OrderPayment], statusUpdates: [StatusUpdate], store: PastOrderStore) {
        self.details = details
        self.items = items
        self.nextState = nextState
        self.nextStates = nextStates
        self.payment = payment
        self.statusUpdates = statusUpdates
        self.store = store
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(OrderDetails.self, from: data)
        self.init(details: me.details, items: me.items, nextState: me.nextState, nextStates: me.nextStates, payment: me.payment, statusUpdates: me.statusUpdates, store: me.store)
    }
}

// MARK: Order convenience initializers and mutators

extension OrderDetails {

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    public func with(
        details: PastOrderDetails? = nil,
        items: [PastOrderItem]? = nil,
        nextState: String? = nil,
        nextStates: [String]? = nil,
        payment: [OrderPayment]? = nil,
        statusUpdates: [StatusUpdate]? = nil,
        store: PastOrderStore? = nil
    ) -> OrderDetails {
        return OrderDetails(
            details: details ?? self.details,
            items: items ?? self.items,
            nextState: nextState ?? self.nextState,
            nextStates: nextStates ?? self.nextStates,
            payment: payment ?? self.payment,
            statusUpdates: statusUpdates ?? self.statusUpdates,
            store: store ?? self.store
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    // public func toDictionary() -> [String: AnyObject] {
//        var dictionary = [String: AnyObject]()
//        dictionary["details"] = details.toDictionary() as AnyObject
//        
//        var dictionaryElements = [[String: AnyObject]]()
//        for itemsElement in items {
//            dictionaryElements.append(itemsElement.toDictionary())
//        }
//        dictionary["items"] = dictionaryElements as AnyObject
//        if let nextState = nextState {
//            dictionary["next_state"] = nextState as AnyObject
//        }
//        dictionary["next_states"] = nextStates as AnyObject
//       
//        dictionaryElements = [[String: AnyObject]]()
//        for paymentElement in payment {
//            dictionaryElements.append(paymentElement.toDictionary())
//        }
//        dictionary["payment"] = dictionaryElements as AnyObject
//        
//        dictionaryElements = [[String: AnyObject]]()
//        for statusUpdatesElement in statusUpdates {
//            dictionaryElements.append(statusUpdatesElement.toDictionary())
//        }
//        dictionary["status_updates"] = dictionaryElements as AnyObject
//        
//        dictionary["store"] = store.toDictionary() as AnyObject
//        
//        return dictionary
//    }
    
    public func toObjcDictionary() -> [String : AnyObject] {
        return toDictionary()
    }
}
