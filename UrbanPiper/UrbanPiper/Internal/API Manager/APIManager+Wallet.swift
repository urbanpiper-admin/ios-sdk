//
//  APIManager+Wallet.swift
//  UrbanPiper
//
//  Created by Vid on 02/07/18.
//

import Foundation

enum WalletAPI {
    case walletTransactions(offset: Int, limit: Int)
}

extension WalletAPI: UPAPI {
    var path: String {
        switch self {
        case .walletTransactions:
            return "api/v2/ub/wallet/transactions/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case let .walletTransactions(offset, limit):
            return ["offset": String(offset),
                    "limit": String(limit)]
        }
    }

    var headers: [String: String]? {
        switch self {
        case .walletTransactions:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .walletTransactions:
            return .GET
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .walletTransactions:
            return nil
        }
    }
}

/* extension APIManager {

 @objc internal func getWalletTransactions(offset: Int = 0,
                                           limit: Int = Constants.fetchLimit,
                                           completion: APICompletion<WalletTransactionResponse>?,
                                           failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v2/ub/wallet/transactions/"

     let url: URL = URL(string: urlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "GET"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 }*/
