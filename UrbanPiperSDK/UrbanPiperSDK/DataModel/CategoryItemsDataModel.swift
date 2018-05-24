//
//  CategoryItemsDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 30/10/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc public protocol CategoryItemsDataModelDelegate {

    func refreshCategoryItemsUI(_ isRefreshing: Bool)
    func handleCategoryItems(error: UPError?)

}

@objc public protocol ItemCellDelegate {
    func object() -> ItemObject?
    func configureCell(_ itemObject: ItemObject?)
}

open class CategoryItemsDataModel: UrbanPiperDataModel {

    weak open var dataModelDelegate: CategoryItemsDataModelDelegate?

    open var categoryItemsResponse: CategoryItemsResponse? {
        didSet {
            setUpSubCategoriesArray()

            dataModelDelegate?.refreshCategoryItemsUI(false)

            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }

    open var itemsArray: [ItemObject]? {
        return categoryItemsResponse?.objects
    }

    open var categoryObject: Object! {
        didSet {
            guard categoryObject.id != nil else { return }
        }
    }

    open var subCategoriesArray: [[ItemObject]]?
    
    open var isFetchingCategoryItems: Bool = false

    open func setUpSubCategoriesArray() {
        if let objects = categoryItemsResponse?.objects {
            let subCategoriesItems = objects.filter { $0.subCategory != nil }

            let keys = subCategoriesItems.compactMap { $0.subCategory.name }
            let tempSet = Set<String>(keys)
            let uniqueKeys = Array(tempSet)

            var subCategoriesArray = [[ItemObject]]()

            for key in uniqueKeys {
                var itemsArray = subCategoriesItems.filter { $0.subCategory.name == key }
                guard itemsArray.count > 0 else { return }
                if itemsArray.count > 1 {
                    itemsArray.sort { $0.sortOrder < $1.sortOrder }
                }
                subCategoriesArray.append(itemsArray)
            }

            if subCategoriesArray.count > 0 {
                if subCategoriesArray.count == 1 {
                    self.subCategoriesArray = subCategoriesArray
                } else {
                    self.subCategoriesArray = subCategoriesArray.sorted { $0.first!.subCategory.sortOrder < $1.first!.subCategory.sortOrder }
                }
                
                var genericItems = objects.filter { $0.subCategory == nil }
                if genericItems.count > 0 {
                    if genericItems.count > 1 {
                        genericItems.sort { $0.sortOrder < $1.sortOrder }
                    }
                    
                    self.subCategoriesArray?.insert(genericItems, at: 0)
                }
                
                return
            }
        }

        subCategoriesArray = nil
    }

    open func refreshData(_ isForcedRefresh: Bool = false) {
        fetchCategoryItems(isForcedRefresh: isForcedRefresh)
    }

}

//  MARK: UITableView DataSource
extension CategoryItemsDataModel {

    open func numberOfSections(in tableView: UITableView) -> Int {
        return subCategoriesArray?.count ?? 1
    }
    

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategoriesArray?[section].count ?? itemsArray?.count ?? 0
    }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)

        if let categoryCell = cell as? ItemCellDelegate {
            let itemObject: ItemObject
            if let subCategoriesArray = subCategoriesArray {
                itemObject = subCategoriesArray[indexPath.section][indexPath.row]
                if subCategoriesArray.last?.last === itemObject, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
                    fetchCategoryItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
                }
            } else {
                itemObject = itemsArray![indexPath.row]
                if itemsArray?.last === itemObject, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
                    fetchCategoryItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
                }
            }
            categoryCell.configureCell(itemObject)
        } else {
            assert(false, "Cell does not conform to ItemCellDelegate protocol")
        }

        return cell
    }

}

//  MARK: UICollectionView DataSource

extension CategoryItemsDataModel {

    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return itemsArray?.count ?? 0
    }

    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier!, for: indexPath)

        if let categoryCell = cell as? ItemCellDelegate {
            categoryCell.configureCell(itemsArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to ItemCellDelegate protocol")
        }

        return cell
    }

}

//  MARK: API Calls

extension CategoryItemsDataModel {

    fileprivate func fetchCategoryItems(isForcedRefresh: Bool, next: String? = nil) {
        guard !isFetchingCategoryItems else { return }
        dataModelDelegate?.refreshCategoryItemsUI(true)
        isFetchingCategoryItems = true
        let dataTask = APIManager.shared.fetchCategoryItems(categoryId: categoryObject.id,
                                                            locationID: OrderingStoreDataModel.nearestStoreResponse?.store?.bizLocationId,
                                                            isForcedRefresh: isForcedRefresh,
                                                            next: next,
                                                            completion: { [weak self] (data) in
                                                                self?.isFetchingCategoryItems = false
                                                                guard let response = data else { return }
                                                                if next == nil {
                                                                    if response.objects.count > 1 {
                                                                        response.objects.sort { $0.sortOrder < $1.sortOrder }
                                                                    }
                                                                    self?.categoryItemsResponse = response
                                                                } else {
                                                                    let currentCategoriesItemsResponse = self?.categoryItemsResponse
                                                                    
                                                                    currentCategoriesItemsResponse?.objects.append(contentsOf: response.objects)
                                                                    currentCategoriesItemsResponse?.meta = response.meta
                                                                    
                                                                    self?.categoryItemsResponse = currentCategoriesItemsResponse
                                                                }
        }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.handleCategoryItems(error: upError)
            }
            self?.isFetchingCategoryItems = false
        })

        addOrCancelDataTask(dataTask: dataTask)
    }
}

//  App State Management

extension CategoryItemsDataModel {

    open override func appWillEnterForeground() {
        guard itemsArray == nil || itemsArray!.count == 0 else { return }
        refreshData(false)
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension CategoryItemsDataModel {

    open override func networkIsAvailable() {
        if itemsArray == nil || itemsArray!.count == 0 {
            refreshData(false)
        }
        
        guard let itemObject = (tableView?.visibleCells.last as? ItemCellDelegate)?.object() else { return }
        if let subCategoriesArray = subCategoriesArray {
            if subCategoriesArray.last?.last === itemObject, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
                fetchCategoryItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
            }
        } else {
            if itemsArray?.last === itemObject, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
                fetchCategoryItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
            }
        }
    }

}