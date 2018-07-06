//
//  APIManager+Wallet.swift
//  UrbanPiperSDK
//
//  Created by Vid on 02/07/18.
//

import UIKit

extension APIManager {

    @objc public func fetchWalletTransactions(completion: APICompletion<WalletTransactionResponse>?,
                                              failure: APIFailure?) -> URLSessionTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v2/ub/wallet/transactions/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let walletTransactionResponse: WalletTransactionResponse = WalletTransactionResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completionClosure(walletTransactionResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                if let failureClosure = failure {
                    guard let apiError: UPAPIError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return dataTask
    }
    
}
