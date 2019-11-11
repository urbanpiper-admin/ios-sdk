//
//  APIManager+Ordering.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum CategoriesAPI {
    case categories(storeId: Int?, offset: Int, limit: Int)
}

extension CategoriesAPI: UPAPI {
    var path: String {
        switch self {
        case .categories:
            return "api/v1/order/categories/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case let .categories(storeId, offset, limit):
            var params = ["format": "json",
                          "offset": String(offset),
                          "limit": String(limit),
                          "biz_id": APIManager.shared.bizId]

            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }

            return params
        }
    }

    var headers: [String: String]? {
        switch self {
        case .categories:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .categories:
            return .GET
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .categories:
            return nil
        }
    }
}
