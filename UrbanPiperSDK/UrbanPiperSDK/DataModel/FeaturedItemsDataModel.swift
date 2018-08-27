//
//  FeaturedItemsDataModel.swift
//  UrbanPiperSDK
//
//  Created by Vid on 11/07/18.
//

import UIKit
import CoreLocation

@objc public protocol FeaturedItemsDataModelDelegate {
    
    func refreshFeaturedItemsUI(_ isRefreshing: Bool)
    
    func handleFeaturedItems(error: UPError?)
}


open class FeaturedItemsDataModel: UrbanPiperDataModel {
    weak open var dataModelDelegate: FeaturedItemsDataModelDelegate?
    
    open var itemIds: [Int] = [0]
    public var filterOutItemsAddedToCart: Bool = false
    
    var fullCategoryItemsResponse: CategoryItemsResponse? {
        didSet {
            if !filterOutItemsAddedToCart {
                categoryItemsResponse = fullCategoryItemsResponse
            } else {
                categoryItemsResponse = filteredCategoryItemsResponse()
            }
        }
    }

    open var categoryItemsResponse: CategoryItemsResponse? {
        didSet {
            dataModelDelegate?.refreshFeaturedItemsUI(false)
            
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }
    
    open var itemsArray: [ItemObject]? {
        return categoryItemsResponse?.objects
    }
    
    open func refreshData(_ isForcedRefresh: Bool = false) {
        fetchFeaturedItems(isForcedRefresh: isForcedRefresh)
    }
    
    public override init() {
        super.init()
        
        CartManager.addObserver(delegate: self)
        OrderingStoreDataModel.shared.addObserver(delegate: self)
    }
    
    func filteredCategoryItemsResponse() -> CategoryItemsResponse? {
        let cartItemIds = CartManager.shared.cartItemIds
        
        if let categoryResponse = fullCategoryItemsResponse?.copy() as? CategoryItemsResponse {
            
            let filteredObjects = categoryResponse.objects.filter({ (itemObject) -> Bool in
                guard cartItemIds.filter({ itemObject.id == $0 }).last == nil else { return false }
                return true
            })
            
            categoryResponse.objects = filteredObjects
            
            return categoryResponse
        } else {
            return fullCategoryItemsResponse
        }
    }

}

//  MARK: API Calls

extension FeaturedItemsDataModel {
    
    fileprivate func fetchFeaturedItems(isForcedRefresh: Bool, next: String? = nil) {
        guard isForcedRefresh || (!isForcedRefresh && categoryItemsResponse == nil) else { return }
        dataModelDelegate?.refreshFeaturedItemsUI(true)
        let dataTask: URLSessionDataTask = APIManager.shared.featuredItems(itemIds: itemIds,
                                                                             locationID: OrderingStoreDataModel.shared.orderingStore?.bizLocationId,
                                                                           next: next,
                                                                           completion: { [weak self] (data) in
                                                                            guard let response = data else { return }
                                                                            if next == nil {
                                                                                if response.objects.count > 1 {
                                                                                    response.objects.sort { (obj1, obj2) in
                                                                                        guard obj1.currentStock != 0 else { return false }
                                                                                        guard obj2.currentStock != 0 else { return true }
                                                                                        
                                                                                        return obj1.sortOrder < obj2.sortOrder
                                                                                    }
                                                                                }
                                                                                self?.fullCategoryItemsResponse = response
                                                                            } else {
                                                                                let currentCategoryItemsResponse = self?.fullCategoryItemsResponse
                                                                                
                                                                                currentCategoryItemsResponse?.objects.append(contentsOf: response.objects)
                                                                                currentCategoryItemsResponse?.meta = response.meta
                                                                                
                                                                                currentCategoryItemsResponse?.objects.sort { (obj1, obj2) in
                                                                                    guard obj1.currentStock != 0 else { return false }
                                                                                    guard obj2.currentStock != 0 else { return true }
                                                                                    
                                                                                    return obj1.sortOrder < obj2.sortOrder
                                                                                }
                                                                                
                                                                                self?.fullCategoryItemsResponse = currentCategoryItemsResponse
                                                                            }
            }, failure: { [weak self] (upError) in
                defer {
                    self?.dataModelDelegate?.handleFeaturedItems(error: upError)
                }
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
}

//  MARK: UITableView DataSource
extension FeaturedItemsDataModel {
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let itemArrayCount = itemsArray?.count {
            return itemArrayCount
        } else {
            return 0
        }
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier!, for: indexPath)
        
        if let categoryCell: ItemCellDelegate = cell as? ItemCellDelegate {
            let itemObject: ItemObject = itemsArray![indexPath.row]
            if itemsArray?.last === itemObject, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
                fetchFeaturedItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
            }
            categoryCell.configureCell(itemObject)
        } else {
            assert(false, "Cell does not conform to ItemCellDelegate protocol")
        }
        
        return cell
    }
    
}

//  MARK: UICollectionView DataSource

extension FeaturedItemsDataModel {
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray?.count ?? 0
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier!, for: indexPath)
        
        if let categoryCell: ItemCellDelegate = cell as? ItemCellDelegate {
            categoryCell.configureCell(itemsArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to ItemCellDelegate protocol")
        }
        
        return cell
    }
    
}

extension FeaturedItemsDataModel: OrderingStoreDataModelDelegate {
    
    open func update(_ storeResponse: StoreResponse?, _ deliveryLocation: CLLocation?, _ error: UPError?, _ storeUpdated: Bool) {
        guard storeUpdated else { return }
        
        fullCategoryItemsResponse = nil
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

extension FeaturedItemsDataModel: CartManagerDelegate {
    
    public func refreshCartUI() {
        guard filterOutItemsAddedToCart else { return }
        categoryItemsResponse = filteredCategoryItemsResponse()
    }
    
    public func handleCart(error: UPError?) {
    }
    
}

//  App State Management

extension FeaturedItemsDataModel {
    
    override open func appWillEnterForeground() {
        guard itemsArray == nil || itemsArray!.count == 0 else { return }
        refreshData(false)
        
        guard let itemObject: ItemObject = (collectionView?.visibleCells.last as? ItemCellDelegate)?.object() else { return }
        if itemsArray?.last === itemObject, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
            fetchFeaturedItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
        }
    }
    
    @objc open override func appDidEnterBackground() {
        
    }
    
}

//  Reachability

extension FeaturedItemsDataModel {
    
    override open func networkIsAvailable() {
        guard itemsArray == nil || itemsArray!.count == 0 else { return }
        refreshData(false)
        
        guard let itemObject: ItemObject = (collectionView?.visibleCells.last as? ItemCellDelegate)?.object() else { return }
        if itemsArray?.last === itemObject, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
            fetchFeaturedItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
        }
    }
    
}