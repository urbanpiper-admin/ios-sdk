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
                              completion: APICompletion<CategoryItemsResponse>?,
                              failure: APIFailure?) -> URLSessionDataTask {
        
        var urlString: String = "\(APIManager.baseUrl)/api/v2/items/"
        
        for id in itemIds {
            if id == itemIds.first! {
                urlString.append("\(id)")
            } else {
                urlString.append(",\(id)")
            }
        }
        
        urlString.append("/recommendations/")
        
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
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let categoryItemsResponse: CategoryItemsResponse = CategoryItemsResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(categoryItemsResponse)
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
