//
//  ItemCategoriesDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 30/10/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit
import CoreLocation

@objc public protocol ItemCategoriesDataModelDelegate {

    func refreshItemCategoriesUI(_ isRefreshing: Bool)
    func handleItemCategories(error: UPError?)

}

@objc public protocol CategoryCellDelegate {
    func configureCell(_ categoriesObject: Object?)
}

open class ItemCategoriesDataModel: UrbanPiperDataModel {

    weak open var dataModelDelegate: ItemCategoriesDataModelDelegate?
    
    open var categoriesResponse: CategoriesResponse? {
        didSet {
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }

    open var categoriesListArray: [Object]? {
        return categoriesResponse?.objects
    }

    public override init() {
        super.init()
        OrderingStoreDataModel.shared.addObserver(delegate: self)

        refreshData(true)
    }

    open func refreshData(_ isForcedRefresh: Bool = false) {
        fetchCategoriesList(isForcedRefresh: isForcedRefresh)
    }

}

//  MARK: UITableView DataSource
extension ItemCategoriesDataModel {

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesListArray?.count ?? 0
    }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)

        if let categoryCell = cell as? CategoryCellDelegate {
            categoryCell.configureCell(categoriesListArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to CategoryCellDelegate protocol")
        }

        return cell
    }
}

//  MARK: UICollectionView DataSource

extension ItemCategoriesDataModel {

    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return categoriesListArray?.count ?? 0
    }

    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier!, for: indexPath)

        if let categoryCell = cell as? CategoryCellDelegate {
            categoryCell.configureCell(categoriesListArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to CategoryCellDelegate protocol")
        }

        return cell
    }

}

//  MARK: API Calls

extension ItemCategoriesDataModel {

    fileprivate func fetchCategoriesList(isForcedRefresh: Bool) {
        guard CLLocationManager.authorizationStatus() != .notDetermined else { return }
        
        guard categoriesListArray == nil || categoriesListArray!.count == 0 || isForcedRefresh else {
            dataModelDelegate?.refreshItemCategoriesUI(false)
            return
        }

        dataModelDelegate?.refreshItemCategoriesUI(true)
        let dataTask = APIManager.shared.fetchCategoriesList(isForcedRefresh, completion: { [weak self] (data) in
            defer {
                self?.dataModelDelegate?.refreshItemCategoriesUI(false)
            }
            guard let response = data else { return }
            self?.categoriesResponse = response
        }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.handleItemCategories(error: upError)
            }
        })

        addOrCancelDataTask(dataTask: dataTask)
    }
}

extension ItemCategoriesDataModel: OrderingStoreDataModelDelegate {
    
    open func update(_ storeResponse: StoreResponse?, _ deliveryLocation: CLLocation?, _ error: UPError?, _ storeUpdated: Bool) {
        guard storeUpdated else { return }

        categoriesResponse = nil
        refreshData(true)
    }
    
    open func handleLocationManagerFailure(error: Error?) {
        refreshData(false)
    }
    
    open func didChangeAuthorization(status: CLAuthorizationStatus) {
        guard status == .notDetermined || status == .restricted || status == .denied else { return }
        refreshData(false)
    }
    
}

//  App State Management

extension ItemCategoriesDataModel {

    override open func appWillEnterForeground() {
        guard categoriesListArray == nil || categoriesListArray!.count == 0 else { return }
        refreshData(false)
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension ItemCategoriesDataModel {

    override open func networkIsAvailable() {
        guard categoriesListArray == nil || categoriesListArray!.count == 0 else { return }
        refreshData(false)
    }

}
