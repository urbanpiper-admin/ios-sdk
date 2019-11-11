//
//  APIManager+Notifications.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum NotificationsAPI {
    case notifications(offset: Int, limit: Int)
}

extension NotificationsAPI: UPAPI {
    var path: String {
        switch self {
        case .notifications:
            return "api/v1/ub/notifications/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case let .notifications(offset, limit):
            return ["channel__in": "app_notification,all",
                    "offset": String(offset),
                    "limit": String(limit)]
        }
    }

    var headers: [String: String]? {
        switch self {
        case .notifications:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .notifications:
            return .GET
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .notifications:
            return nil
        }
    }
}
