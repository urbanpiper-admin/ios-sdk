//
//  APIManager+Items.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum ItemsAPI {
    case filterAndSortOptions(categoryId: Int)
    case categoryItems(categoryId: Int, storeId: Int?, offset: Int, limit: Int, sortKey: String?, filterOptions: [FilterOption]?)
    case searchItems(query: String, storeId: Int?, offset: Int, limit: Int)
    case itemDetails(itemId: Int, storeId: Int?)
    case featuredItems(storeId: Int?, offset: Int, limit: Int)
    case relatedItems(itemIds: [Int], storeId: Int?, offset: Int, limit: Int)
    case associatedItems(itemId: Int, storeId: Int?, offset: Int, limit: Int)
}

extension ItemsAPI: UPAPI {
    var path: String {
        switch self {
        case let .filterAndSortOptions(categoryId):
            return "api/v2/categories/\(categoryId)/options/"
        case let .categoryItems(categoryId, _, _, _, _, _):
            return "api/v1/order/categories/\(categoryId)/items/"
        case .searchItems:
            return "api/v2/search/items/"
        case let .itemDetails(itemId, _):
            return "api/v1/items/\(itemId)/"
        case .featuredItems:
            return "api/v2/items/0/recommendations/"
        case let .relatedItems(itemIds, _, _, _):
            let itemIdsString = itemIds.map { "\($0)" }.joined(separator: ",")
            return "api/v2/items/\(itemIdsString)/recommendations/"
        case let .associatedItems(itemId, _, _, _):
            return "api/v2/items/\(itemId)/recommendations/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case .filterAndSortOptions:
            return nil
        case let .categoryItems(_, storeId, offset, limit, sortKey, filterOptions):
            var params = ["format": "json",
                          "offset": String(offset),
                          "limit": String(limit),
                          "biz_id": APIManager.shared.bizId]

            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }

            if let key = sortKey {
                params["sort_by"] = key
            }

            if let options = filterOptions, options.count > 0 {
                let keysArray = options.map { String($0.id) }
                let filterKeysString = keysArray.joined(separator: ",")
                params["filter_by"] = filterKeysString
            }

            return params
        case let .searchItems(query, storeId, offset, limit):
            var params = ["keyword": query,
                          "offset": "\(offset)",
                          "limit": "\(limit)",
                          "biz_id": APIManager.shared.bizId]

            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }

            return params
        case let .itemDetails(_, storeId):

            let now: Date = Date()
            let timeInt = String(now.timeIntervalSince1970 * 1000)

            var params: [String: String] = ["cx": timeInt]

            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }

            return params
        case let .featuredItems(storeId, offset, limit):
            var params = ["offset": String(offset),
                          "limit": String(limit)]

            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }

            return params
        case let .relatedItems(_, storeId, offset, limit):
            var params = ["offset": String(offset),
                          "limit": String(limit)]

            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }

            return params
        case let .associatedItems(_, storeId, offset, limit):
            var params = ["offset": String(offset),
                          "limit": String(limit)]

            if let storeId = storeId {
                params["location_id"] = String(storeId)
            }

            return params
        }
    }

    var headers: [String: String]? {
        switch self {
        case .filterAndSortOptions:
            return ["Authorization": APIManager.shared.bizAuth()]
        case .categoryItems:
            return nil
        case .searchItems:
            return nil
        case .itemDetails:
            return nil
        case .featuredItems:
            return ["Authorization": APIManager.shared.bizAuth()]
        case .relatedItems:
            return ["Authorization": APIManager.shared.bizAuth()]
        case .associatedItems:
            return ["Authorization": APIManager.shared.bizAuth()]
        }
    }

    var method: HttpMethod {
        switch self {
        case .filterAndSortOptions:
            return .GET
        case .categoryItems:
            return .GET
        case .searchItems:
            return .GET
        case .itemDetails:
            return .GET
        case .featuredItems:
            return .GET
        case .relatedItems:
            return .GET
        case .associatedItems:
            return .GET
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .filterAndSortOptions:
            return nil
        case .categoryItems:
            return nil
        case .searchItems:
            return nil
        case .itemDetails:
            return nil
        case .featuredItems:
            return nil
        case .relatedItems:
            return nil
        case .associatedItems:
            return nil
        }
    }
}
