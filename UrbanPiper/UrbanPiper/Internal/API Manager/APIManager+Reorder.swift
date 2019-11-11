//
//  APIManager+Reorder.swift
//  UrbanPiper
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import CoreLocation
import Foundation

enum ReorderAPI {
    case reorder(orderId: Int, userLocation: CLLocationCoordinate2D?, storeId: Int?)
}

extension ReorderAPI: UPAPI {
    var path: String {
        switch self {
        case let .reorder(orderId, _, _):
            return "api/v2/order/\(orderId)/reorder/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case let .reorder(_, userLocation, storeId):
            var params = [String: String]()

            if let lat = userLocation?.latitude, let lng = userLocation?.longitude, lat != 0, lng != 0 {
                params["lat"] = String(lat)
                params["lng"] = String(lng)
            }

            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }

            return params
        }
    }

    var headers: [String: String]? {
        switch self {
        case .reorder:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .reorder:
            return .GET
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .reorder:
            return nil
        }
    }
}
