//
//  APIManager+Wallet.swift
//  UrbanPiperSDK
//
//  Created by Vid on 02/07/18.
//

import Foundation

extension APIManager {

    @objc public func fetchWalletTransactions(completion: ((WalletTransactionResponse?) -> Void)?,
                                              failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v2/ub/wallet/transactions/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
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
                self?.handleAPIError(errorCode: statusCode ?? 0, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
}
