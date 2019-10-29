//
//  ViewController.swift
//  UrbanPiper-Example
//
//  Created by Vid on 03/07/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import UIKit
import UrbanPiper
import RxSwift

class ViewController: UIViewController {
    
    var disposeBag: DisposeBag = DisposeBag()
    
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
        
        login()
    }
    
    func login() {
        UrbanPiper.sharedInstance().login(phone: "+918903464104", password: "qwerty")
            .subscribe(onNext: { [weak self] (loginResponse) in
                print(loginResponse.toDictionary() as AnyObject)
                self?.getNearestStore()
            }, onError: { (error) in
                print(error as Any)
            }, onCompleted: {
                print("completed")
            })
            .disposed(by: disposeBag)
    }
    
    func getNearestStore() {
        UrbanPiper.sharedInstance().getNearestStore(lat: 12.970171, lng: 77.7306347)
            .subscribe(onNext: { (storeResponse) in
                print(storeResponse.toDictionary() as AnyObject)
                
                let storeResponseData: Data = NSKeyedArchiver.archivedData(withRootObject: storeResponse as Any)
                UserDefaults.standard.set(storeResponseData, forKey: "nearestStoreResponseKey")
                
                guard let storeResponseDataSaved: Data = UserDefaults.standard.object(forKey: "nearestStoreResponseKey") as? Data else { return }
                guard let storeResponseSaved: StoreResponse = NSKeyedUnarchiver.unarchiveObject(with: storeResponseDataSaved) as? StoreResponse else { return }
                print(storeResponseSaved.toDictionary() as AnyObject)
            }, onError: { (error) in
                print(error as Any)
            }, onCompleted: {
                print("completed")
            })
        .disposed(by: disposeBag)
    }

}

