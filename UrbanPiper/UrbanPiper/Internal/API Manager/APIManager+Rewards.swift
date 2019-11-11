//
//  APIManager+Rewards.swift
//  UrbanPiper
//
//  Created by Vid on 12/02/19.
//

import UIKit

enum RewardsAPI {
    case rewards(offset: Int, limit: Int)
    case reedemRewards(rewardId: Int)
}

extension RewardsAPI: UPAPI {
    var path: String {
        switch self {
        case .rewards:
            return "api/v2/rewards/"
        case let .reedemRewards(rewardId):
            return "api/v2/rewards/\(rewardId)/redeem/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case .rewards:
            return nil
        case .reedemRewards:
            return nil
        }
    }

    var headers: [String: String]? {
        switch self {
        case .rewards:
            return nil
        case .reedemRewards:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .rewards:
            return .GET
        case .reedemRewards:
            return .POST
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .rewards:
            return nil
        case .reedemRewards:
            return nil
        }
    }
}
