//
//  APIManager+Biz.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum UserBizInfoAPI {
    case userBizInfo
}

extension UserBizInfoAPI: UPAPI {
    var path: String {
        switch self {
        case .userBizInfo:
            return "api/v1/userbizinfo/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case .userBizInfo:
            return ["format": "json",
                    "biz_id": APIManager.shared.bizId]
        }
    }

    var headers: [String: String]? {
        switch self {
        case .userBizInfo:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .userBizInfo:
            return .GET
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .userBizInfo:
            return nil
        }
    }
}
