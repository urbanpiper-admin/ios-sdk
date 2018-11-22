//
//  APIManager+StoreLocator.swift
//  UrbanPiperSDK
//
//  Created by Vid on 04/07/18.
//

import Foundation
import CoreLocation

extension APIManager {
    
    @objc public func fetchAllStores(completion: ((StoreLocatorResponse?) -> Void)?,
                                     failure: APIFailure?) -> URLSessionDataTask {
        
        let bizId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId
        let urlString: String = "\(APIManager.baseUrl)/api/v1/stores/?format=json&biz_id=\(bizId)&all=1"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
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
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    @objc public func fetchNearestStore(_ coordinates: CLLocationCoordinate2D,
                                        completion: ((StoreResponse?) -> Void)?,
                                        failure: APIFailure?) -> URLSessionDataTask {
        
        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/stores/?format=json&biz_id=\(appId)&lat=\(coordinates.latitude)&lng=\(coordinates.longitude)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let storeResponse: StoreResponse = StoreResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(storeResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
}

