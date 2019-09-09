//
//  ViewController.swift
//  UrbanPiper-Example
//
//  Created by Vid on 03/07/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import UIKit
import UrbanPiper

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let language = Language.english
        let bizId = "76720224"
        let apiUsername = "biz_adm_clients_yjXwAgQzHqYM"
        let apiKey = "5ee66ab0ec691963ebe2e9485ae0fdfe232d8fa8"
        
        UrbanPiper.intialize(language: language, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey) { (sdkEvent) in
            print("sdkEvent \(sdkEvent)")
        }
        
        UrbanPiper.sharedInstance().logout()
        
        UrbanPiper.sharedInstance().login(phone: "+918903464104", password: "qwerty", completion: { (loginResponse) in
            print(loginResponse?.toDictionary() as AnyObject)
            UrbanPiper.sharedInstance().getNearestStore(lat: 12.970171, lng: 77.7306347, completion: { (storeResponse) in
                print(storeResponse?.toDictionary() as AnyObject)
                
                let storeResponseData: Data = NSKeyedArchiver.archivedData(withRootObject: storeResponse as Any)
                UserDefaults.standard.set(storeResponseData, forKey: "nearestStoreResponseKey")
                
                guard let storeResponseDataSaved: Data = UserDefaults.standard.object(forKey: "nearestStoreResponseKey") as? Data else { return }
                guard let storeResponseSaved: StoreResponse = NSKeyedUnarchiver.unarchiveObject(with: storeResponseDataSaved) as? StoreResponse else { return }
                print(storeResponseSaved.toDictionary() as AnyObject)
            }, failure: { (error) in
                print(error as Any)
            })
            
//            UrbanPiper.sharedInstance().getCategories(storeId: nil, completion: { (categoriesResponse) in
//                print(categoriesResponse?.toDictionary() as AnyObject)
//            }, failure: { (error) in
//                print(error as Any)
//            })
            
        }, failure: { (error) in
            print(error as Any)
        })
        
        

    }

}

