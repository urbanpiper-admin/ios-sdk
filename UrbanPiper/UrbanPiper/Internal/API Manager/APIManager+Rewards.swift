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
        case .reedemRewards(let rewardId):
            return "api/v2/rewards/\(rewardId)/redeem/"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .rewards:
            return nil
        case .reedemRewards:
            return nil
        }
    }
    
    var headers: [String : String]? {
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
    
    var body: [String : AnyObject]? {
        switch self {
        case .rewards:
            return nil
        case .reedemRewards:
            return nil
        }
    }
    
}

extension APIManager {
    
    internal func getRewards(completion: ((RewardsResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask {
        let urlString: String = "\(APIManager.baseUrl)/api/v2/rewards/"

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)!
    }

    internal func redeemReward(rewardId: Int, completion: ((RedeemRewardResponse?) -> Void)?,
                                              failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v2/rewards/\(rewardId)/redeem/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)!
    }
    
}
