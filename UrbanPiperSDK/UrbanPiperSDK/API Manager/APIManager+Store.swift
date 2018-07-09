//
//  APIManager+StoreLocator.swift
//  UrbanPiperSDK
//
//  Created by Vid on 04/07/18.
//

import Foundation
import CoreLocation

extension APIManager {
    
    @objc public func fetchAllStores(completion: APICompletion<StoreLocatorResponse>?,
                                     failure: APIFailure?) -> URLSessionDataTask {
        
        let bizAppId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId
        let urlString: String = "\(APIManager.baseUrl)/api/v1/stores/?format=json&biz_id=\(bizAppId)&all=1"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let storeLocatorResponse: StoreLocatorResponse = StoreLocatorResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(storeLocatorResponse)
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
    
    @objc public func fetchNearestStore(_ coordinates: CLLocationCoordinate2D,
                                        completion: APICompletion<StoreResponse>?,
                                        failure: APIFailure?) -> URLSessionDataTask {
        
        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/stores/?format=json&biz_id=\(appId)&lat=\(coordinates.latitude)&lng=\(coordinates.longitude)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let storeDetail: StoreResponse = StoreResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(storeDetail)
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

