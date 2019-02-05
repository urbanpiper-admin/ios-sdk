//
//  APIManager+Recomendation.swift
//  UrbanPiperSDK
//
//  Created by Vid on 10/07/18.
//

import UIKit

extension APIManager {

    public func featuredItems(itemIds: [Int] = [0],
                              locationID: Int?,
                              next: String?,
                              completion: ((CategoryItemsResponse?) -> Void)?,
                              failure: APIFailure?) -> URLSessionDataTask {
        let itemIdsString = itemIds.map { "\($0)" }.joined(separator: ",")
        var urlString: String = "\(APIManager.baseUrl)/api/v2/items/\(itemIdsString)/recommendations/"
        
        if let id = locationID {
            urlString = "\(urlString)?location_id=\(id)"
        }
        
        if let nextUrlString: String = next {
            urlString = "\(APIManager.baseUrl)\(nextUrlString)"
        }
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.setValue(bizAuth(), forHTTPHeaderField: "Authorization")

        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let isUpsoldItems = itemIds.count > 1
                    let isRecommendedItems = itemIds.count == 1 && itemIds.last! == 0
                    let categoryItemsResponse: CategoryItemsResponse = CategoryItemsResponse(fromDictionary: dictionary,
                                                                                             isUpsoldItems: isUpsoldItems,
                                                                                             isRecommendedItems: isRecommendedItems)
                    
                    DispatchQueue.main.async {
                        completion?(categoryItemsResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
}
