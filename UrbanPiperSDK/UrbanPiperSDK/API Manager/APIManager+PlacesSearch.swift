//
//  APIManager+PlacesSearch.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 09/04/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {
    
    @objc public func fetchCoordinates(from placeId: String,
                                completion: APICompletion<PlaceDetailsResponse>?,
                                failure: APIFailure?) -> URLSessionDataTask {
        let placesAPIKey: String = AppConfigManager.shared.firRemoteConfigDefaults.googlePlacesApiKey!

        var urlString: String = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&sensor=false&key=\(placesAPIKey)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let placeDetailsResponse: PlaceDetailsResponse = PlaceDetailsResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(placeDetailsResponse)
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
    
    @objc public func reverseGeoCode(lat: Double,
                                     lng: Double,
                                       completion: APICompletion<Address>?,
                                       failure: APIFailure?) -> URLSessionDataTask {
        let placesAPIKey: String = AppConfigManager.shared.firRemoteConfigDefaults.googlePlacesApiKey!
        
        var urlString: String = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(lng)&key=\(placesAPIKey)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let placeDetailsResponse: PlaceDetailsResponse = PlaceDetailsResponse(fromDictionary: dictionary)
                    var address: Address?
                    
                    if placeDetailsResponse.result != nil {
                        address = Address(placeDetailsResponse: placeDetailsResponse)
                    }
                    
                    DispatchQueue.main.async {
                        completionClosure(address)
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
    
    @objc public func fetchPlaces(for keyword: String,
                                  completion: APICompletion<GooglePlacesResponse>?,
                                  failure: APIFailure?) -> URLSessionDataTask {
        
        let bizCountry2LetterCode: String
        
        if let countryCode = AppConfigManager.shared.firRemoteConfigDefaults.bizCountry2LetterCode, countryCode.count > 0 {
            bizCountry2LetterCode = countryCode
        } else {
            bizCountry2LetterCode = "IN"
        }
        
        let placesAPIKey: String = AppConfigManager.shared.firRemoteConfigDefaults.googlePlacesApiKey!
        
        var urlString: String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?sensor=false&key=\(placesAPIKey)&components=country:\(bizCountry2LetterCode)&input=\(keyword)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let placesResponse: GooglePlacesResponse = GooglePlacesResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(placesResponse)
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
