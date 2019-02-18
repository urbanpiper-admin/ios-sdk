//
//  APIManager+StoreLocator.swift
//  UrbanPiperSDK
//
//  Created by Vid on 04/07/18.
//

import Foundation
import CoreLocation

extension APIManager {
    
    @objc internal func getAllStores(completion: ((StoreListResponse?) -> Void)?,
                                     failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/stores/?format=json&biz_id=\(bizId)&all=1"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: urlRequest, responseParser: { (dictionary) -> StoreListResponse? in
            return StoreListResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let storeListResponse: StoreListResponse = StoreListResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(storeListResponse)
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
        
        return dataTask*/
    }
    
    @objc internal func getNearestStore(_ coordinates: CLLocationCoordinate2D,
                                        completion: ((StoreResponse?) -> Void)?,
                                        failure: APIFailure?) -> URLSessionDataTask {
        
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/stores/?format=json&biz_id=\(bizId)&lat=\(coordinates.latitude)&lng=\(coordinates.longitude)"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: urlRequest, responseParser: { (dictionary) -> StoreResponse? in
            return StoreResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let storeResponse: StoreResponse = StoreResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completion?(storeResponse)
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
        
        return dataTask*/
    }
}

