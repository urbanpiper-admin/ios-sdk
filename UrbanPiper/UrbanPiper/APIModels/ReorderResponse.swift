// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let reorderResponse = try ReorderResponse(json)

import Foundation

// MARK: - ReorderResponse
@objcMembers public class ReorderResponse: NSObject, JSONDecodable {
    public let bizLocation: BizLocation
    public let deliveryCharge: Int
    public let itemsAvailable: [ReorderItem]?
    public let itemsNotAvailable: [ReorderItem]?
    public let orderItemTaxes, orderSubtotal, orderTotal, packagingCharge: Double

    enum CodingKeys: String, CodingKey {
        case bizLocation = "biz_location"
        case deliveryCharge = "delivery_charge"
        case itemsAvailable = "items_available"
        case itemsNotAvailable = "items_not_available"
        case orderItemTaxes = "order_item_taxes"
        case orderSubtotal = "order_subtotal"
        case orderTotal = "order_total"
        case packagingCharge = "packaging_charge"
    }

    init(bizLocation: BizLocation, deliveryCharge: Int, itemsAvailable: [ReorderItem]?, itemsNotAvailable: [ReorderItem]?, orderItemTaxes: Double, orderSubtotal: Double, orderTotal: Double, packagingCharge: Double) {
        self.bizLocation = bizLocation
        self.deliveryCharge = deliveryCharge
        self.itemsAvailable = itemsAvailable
        self.itemsNotAvailable = itemsNotAvailable
        self.orderItemTaxes = orderItemTaxes
        self.orderSubtotal = orderSubtotal
        self.orderTotal = orderTotal
        self.packagingCharge = packagingCharge
    }
    
    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ReorderResponse.self, from: data)
        self.init(bizLocation: me.bizLocation, deliveryCharge: me.deliveryCharge, itemsAvailable: me.itemsAvailable, itemsNotAvailable: me.itemsNotAvailable, orderItemTaxes: me.orderItemTaxes, orderSubtotal: me.orderSubtotal, orderTotal: me.orderTotal, packagingCharge: me.packagingCharge)
    }
}

// MARK: ReorderResponse convenience initializers and mutators

extension ReorderResponse {

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
        bizLocation: BizLocation? = nil,
        deliveryCharge: Int? = nil,
        itemsAvailable: [ReorderItem]? = nil,
        itemsNotAvailable: [ReorderItem]? = nil,
        orderItemTaxes: Double? = nil,
        orderSubtotal: Double? = nil,
        orderTotal: Double? = nil,
        packagingCharge: Double? = nil
    ) -> ReorderResponse {
        return ReorderResponse(
            bizLocation: bizLocation ?? self.bizLocation,
            deliveryCharge: deliveryCharge ?? self.deliveryCharge,
            itemsAvailable: itemsAvailable ?? self.itemsAvailable,
            itemsNotAvailable: itemsNotAvailable ?? self.itemsNotAvailable,
            orderItemTaxes: orderItemTaxes ?? self.orderItemTaxes,
            orderSubtotal: orderSubtotal ?? self.orderSubtotal,
            orderTotal: orderTotal ?? self.orderTotal,
            packagingCharge: packagingCharge ?? self.packagingCharge
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
