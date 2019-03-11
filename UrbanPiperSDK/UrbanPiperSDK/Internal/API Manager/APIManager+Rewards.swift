//
//  APIManager+Rewards.swift
//  UrbanPiperSDK
//
//  Created by Vid on 12/02/19.
//

import UIKit

extension APIManager {
    
    internal func getRewards(completion: ((RewardsResponse?) -> Void)?, failure: APIFailure?) -> URLSessionDataTask {
        let urlString: String = "\(APIManager.baseUrl)/api/v2/rewards/"

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"


        return apiRequest(urlRequest: urlRequest, responseParser: { (dictionary) -> RewardsResponse? in
            return RewardsResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
    }

    internal func redeemReward(rewardId: Int, completion: ((RedeemRewardResponse?) -> Void)?,
                                              failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v2/rewards/\(rewardId)/redeem/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        
        return apiRequest(urlRequest: urlRequest, responseParser: { (dictionary) -> RedeemRewardResponse? in
            return RedeemRewardResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
    }
    
}
