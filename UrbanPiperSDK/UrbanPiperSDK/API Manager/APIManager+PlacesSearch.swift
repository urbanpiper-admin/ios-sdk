//
//  APIManager+PlacesSearch.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 09/04/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension APIManager {

    @objc public func fetchPlaces(for keyword: String,
                           completion: APICompletion<GooglePlacesResponse>?,
                           failure: APIFailure?) -> URLSessionTask {
        
        let placesAPIKey = AppConfigManager.shared.firRemoteConfigDefaults.googlePlacesApiKey!

        var bizCountry2LetterCode = AppConfigManager.shared.firRemoteConfigDefaults.bizCountry2LetterCode

        if let code = bizCountry2LetterCode, code.count > 0 {
            let charSet = NSCharacterSet.whitespacesAndNewlines.inverted
            if code.rangeOfCharacter(from: charSet) == nil {
                bizCountry2LetterCode = "IN"
            }
        }

        let urlString = "https://maps.googleapis.com/maps/api/place/autocomplete/json?sensor=false&key=\(placesAPIKey)&components=country:\(bizCountry2LetterCode)&input=\(keyword)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let url = URL(string: urlString!)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let placesResponse = GooglePlacesResponse(fromDictionary: dictionary)
                    
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
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return task
    }
    
    @objc public func fetchCoordinates(from placeId: String,
                                completion: APICompletion<PlaceDetailsResponse>?,
                                failure: APIFailure?) -> URLSessionTask {
        let placesAPIKey = AppConfigManager.shared.firRemoteConfigDefaults.googlePlacesApiKey!

        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&sensor=false&key=\(placesAPIKey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: urlString!)!
        
        print("url \(url)")
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let placeDetailsResponse = PlaceDetailsResponse(fromDictionary: dictionary)
                    
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
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }
            
        }
        
        return task
    }
    
}
