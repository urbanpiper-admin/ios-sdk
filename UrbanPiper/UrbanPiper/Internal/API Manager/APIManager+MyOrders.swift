//
//  APIManager+MyOrders.swift
//  UrbanPiper
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import Foundation

enum PastOrdersAPI {
    case pastOrders(offset: Int, limit: Int)
    case pastOrderDetails(orderId: Int)
}

extension PastOrdersAPI: UPAPI {
    var path: String {
        switch self {
        case .pastOrders:
            return "api/v2/orders/"
        case let .pastOrderDetails(orderId):
            return "api/v2/orders/\(orderId)/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case let .pastOrders(offset, limit):
            return ["offset": String(offset),
                    "limit": String(limit)]
        case .pastOrderDetails:
            return nil
        }
    }

    var headers: [String: String]? {
        switch self {
        case .pastOrders:
            return nil
        case .pastOrderDetails:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .pastOrders:
            return .GET
        case .pastOrderDetails:
            return .GET
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .pastOrders:
            return nil
        case .pastOrderDetails:
            return nil
        }
    }
}
