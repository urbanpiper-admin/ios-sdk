//
//  StoreLocatorDataModel.swift
//  UrbanPiperSDK
//
//  Created by Vid on 04/07/18.
//

import UIKit

@objc public protocol StoreLocatorDataModelDelegate {
    
    func refreshStoreLocatorUI(_ isRefreshing: Bool)
    func handleStoreLocator(error: UPError?)
    
}

@objc public protocol StoreLocatorCellDelegate {
    func configureCell(_ store: Store?)
}

public class StoreLocatorDataModel: UrbanPiperDataModel {
    
    weak public var dataModelDelegate: StoreLocatorDataModelDelegate?
    
    public var storeLocatorResponse: StoreLocatorResponse? {
        didSet {
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }
    
    public var storesListArray: [Store]? {
        return storeLocatorResponse?.stores
    }
    
    public convenience init(delegate: StoreLocatorDataModelDelegate) {
        self.init()
        
        dataModelDelegate = delegate
        
        refreshData()
    }
    
    public func refreshData(_ isForcedRefresh: Bool = false) {
        fetchStores()
    }
    
    public func fetchStores() {
        dataModelDelegate?.refreshStoreLocatorUI(true)
        let dataTask: URLSessionTask = APIManager.shared.fetchAllStores(completion: { [weak self] (storeLocatorResponse) in
            defer {
                self?.dataModelDelegate?.refreshStoreLocatorUI(false)
            }
            guard let response = storeLocatorResponse else {
                self?.storeLocatorResponse = nil
                return
            }
            self?.sortAndSetResponse(response: response)
            }, failure: { [weak self] (upError) in
                defer {
                    self?.dataModelDelegate?.handleStoreLocator(error: upError)
                }
        })

        addOrCancelDataTask(dataTask: dataTask)
    }
    
    func sortAndSetResponse(response: StoreLocatorResponse) {
        
        if let userLocation = LocationManagerDataModel.shared.currentUserLocation, response.stores != nil {
            for store in response.stores {
                store.distance = store.distanceFrom(location: userLocation)
            }
            response.stores?.sort { (store1, store2) -> Bool in
                guard let distance1 = store1.distance else { return false }
                guard let distance2 = store2.distance else { return true }
                
                return distance1 < distance2
            }
        }
        
        storeLocatorResponse = response
    }
    
}

//  MARK: UITableView DataSource
extension StoreLocatorDataModel {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storesListArray?.count ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)
        
        if let placesCell: StoreLocatorCellDelegate = cell as? StoreLocatorCellDelegate {
            placesCell.configureCell(storesListArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to StoreLocatorCellDelegate protocol")
        }
        
        return cell
    }
}

//  MARK: UICollectionView DataSource

extension StoreLocatorDataModel {
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storesListArray?.count ?? 0
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier!, for: indexPath)
        
        if let placesCell: StoreLocatorCellDelegate = cell as? StoreLocatorCellDelegate {
            placesCell.configureCell(storesListArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to StoreLocatorCellDelegate protocol")
        }
        
        return cell
    }
    
}

//  App State Management

extension StoreLocatorDataModel {
    
    @objc open override func appWillEnterForeground() {
        guard storesListArray == nil || storesListArray!.count == 0 else { return }
        refreshData(true)
    }
    
    @objc open override func appDidEnterBackground() {
    }
    
}

//  Reachability

extension StoreLocatorDataModel {
    
    @objc open override func networkIsAvailable() {
        guard storesListArray == nil || storesListArray!.count == 0 else { return }
        refreshData(true)
    }
    
}
