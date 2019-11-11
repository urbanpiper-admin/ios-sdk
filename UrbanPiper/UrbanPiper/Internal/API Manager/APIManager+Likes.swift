//
//  APIManager+Items.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum ItemLikesAPI {
    case userLikes
    case likeItem(itemId: Int)
    case unlikeItem(itemId: Int)
}

extension ItemLikesAPI: UPAPI {
    var path: String {
        switch self {
        case .userLikes:
            return "api/v1/user/item/likes/"
        case let .likeItem(itemId):
            return "api/v1/user/item/\(itemId)/like/"
        case let .unlikeItem(itemId):
            return "api/v1/user/item/\(itemId)/like/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case .userLikes:
            return nil
        case .likeItem:
            return nil
        case .unlikeItem:
            return nil
        }
    }

    var headers: [String: String]? {
        switch self {
        case .userLikes:
            return nil
        case .likeItem:
            return nil
        case .unlikeItem:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .userLikes:
            return .GET
        case .likeItem:
            return .POST
        case .unlikeItem:
            return .DELETE
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .userLikes:
            return nil
        case .likeItem:
            return nil
        case .unlikeItem:
            return nil
        }
    }
}
