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
    func refreshFilterSortUI(_ isRefreshing: Bool)
    func handleCategoryItems(error: UPError?)

}

@objc public protocol ItemCellDelegate {
    func object() -> Item?
    func configureCell(_ item: Item?, extras: Extras?)
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

    open var itemsArray: [Item]? {
        return categoryItemsResponse?.objects
    }

    open var categoryObject: Object! {
        didSet {
            guard categoryObject.id != nil else { return }
        }
    }

    open var subCategoriesArray: [[Item]]?
    
    public var categoryOptionsResponse: CategoryOptionsResponse?
    
    public var selectedSortOption: String?
    
    public var selectedFilterOptions: [FilterOption] = []
    
    private var categoryOptionsApplied = true
    
    open var isFetchingCategoryItems: Bool = false

    open func setUpSubCategoriesArray() {
        if let objects = categoryItemsResponse?.objects {
            let subCategoriesItems: [Item] = objects.filter { $0.subCategory != nil }

            let keys = subCategoriesItems.compactMap { $0.subCategory?.name }
            let tempSet: Set<String> = Set<String>(keys)
            let uniqueKeys: Array = Array(tempSet)

            var subCategoriesArray = [[Item]]()

            for key in uniqueKeys {
                var itemsArray: [Item] = subCategoriesItems.filter { $0.subCategory?.name == key }
                guard itemsArray.count > 0 else { return }
                if itemsArray.count > 1 {
                    itemsArray.sort { (obj1, obj2) in
                        guard obj1.currentStock != 0 else { return false }
                        guard obj2.currentStock != 0 else { return true }
                        
                        return obj1.sortOrder < obj2.sortOrder
                    }
                }
                subCategoriesArray.append(itemsArray)
            }

            if subCategoriesArray.count > 0 {
                if subCategoriesArray.count == 1 {
                    self.subCategoriesArray = subCategoriesArray
                } else {
                    self.subCategoriesArray = subCategoriesArray.sorted { $0.first!.subCategory!.sortOrder < $1.first!.subCategory!.sortOrder }
                }
                
                var genericItems: [Item] = objects.filter { $0.subCategory == nil }
                if genericItems.count > 0 {
                    if genericItems.count > 1 {
                        genericItems.sort { (obj1, obj2) in
                            guard obj1.currentStock != 0 else { return false }
                            guard obj2.currentStock != 0 else { return true }
                            
                            return obj1.sortOrder < obj2.sortOrder
                        }
                    }
                    
                    self.subCategoriesArray?.insert(genericItems, at: 0)
                }
                
                return
            }
        }

        subCategoriesArray = nil
    }

    open func refreshData(_ isForcedRefresh: Bool = false) {
        fetchCategoryOptions()
        fetchCategoryItems(isForcedRefresh: isForcedRefresh)
    }

}

//  MARK: UITableView DataSource
extension CategoryItemsDataModel {

    open func numberOfSections(in tableView: UITableView) -> Int {
        return subCategoriesArray?.count ?? 1
    }
    

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let subCategoryCount = subCategoriesArray?[section].count {
            return subCategoryCount
        } else if let itemArrayCount = itemsArray?.count {
            return itemArrayCount
        } else {
            return 0
        }
    }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier!, for: indexPath)

        if let categoryCell: ItemCellDelegate = cell as? ItemCellDelegate {
            let item: Item
            if let subCategoriesArray = subCategoriesArray {
                item = subCategoriesArray[indexPath.section][indexPath.row]
                if subCategoriesArray.last?.last === item, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
                    fetchCategoryItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
                }
            } else {
                item = itemsArray![indexPath.row]
                if itemsArray?.last === item, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
                    fetchCategoryItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
                }
            }
            categoryCell.configureCell(item, extras: extras)
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
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier!, for: indexPath)

        if let categoryCell: ItemCellDelegate = cell as? ItemCellDelegate {
            categoryCell.configureCell(itemsArray?[indexPath.row], extras: extras)
        } else {
            assert(false, "Cell does not conform to ItemCellDelegate protocol")
        }

        return cell
    }

}

//  MARK: API Calls

extension CategoryItemsDataModel {

    fileprivate func fetchCategoryItems(isForcedRefresh: Bool, next: String? = nil) {
        guard isForcedRefresh || (!isForcedRefresh && categoryItemsResponse == nil) else { return }
        guard !isFetchingCategoryItems else { return }
        dataModelDelegate?.refreshCategoryItemsUI(true)
        isFetchingCategoryItems = true
        let dataTask: URLSessionDataTask = APIManager.shared.getCategoryItems(categoryId: categoryObject.id,
                                                            locationID: OrderingStoreDataModel.shared.orderingStore?.bizLocationId,
                                                            sortKey: selectedSortOption,
                                                            filterOptions: selectedFilterOptions,
//                                                            isForcedRefresh: isForcedRefresh,
//                                                            next: next,
                                                            completion: { [weak self] (data) in
                                                                self?.isFetchingCategoryItems = false
                                                                self?.categoryOptionsApplied = true
                                                                guard let response = data else { return }
                                                                if next == nil {
                                                                    if response.objects.count > 1 {
                                                                        response.objects.sort { (obj1, obj2) in
                                                                            guard obj1.currentStock != 0 else { return false }
                                                                            guard obj2.currentStock != 0 else { return true }
                                                                            
                                                                            return obj1.sortOrder < obj2.sortOrder
                                                                        }
                                                                    }
                                                                    self?.categoryItemsResponse = response
                                                                } else {
                                                                    let currentCategoriesItemsResponse = self?.categoryItemsResponse
                                                                    
                                                                    currentCategoriesItemsResponse?.objects.append(contentsOf: response.objects)
                                                                    currentCategoriesItemsResponse?.meta = response.meta
                                                                    
                                                                    currentCategoriesItemsResponse?.objects.sort { (obj1, obj2) in
                                                                        guard obj1.currentStock != 0 else { return false }
                                                                        guard obj2.currentStock != 0 else { return true }
                                                                        
                                                                        return obj1.sortOrder < obj2.sortOrder
                                                                    }
                                                                    
                                                                    self?.categoryItemsResponse = currentCategoriesItemsResponse
                                                                }
        }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.handleCategoryItems(error: upError)
            }
            self?.categoryOptionsApplied = false
            self?.isFetchingCategoryItems = false
        })

        addDataTask(dataTask: dataTask)
    }
    
    fileprivate func fetchCategoryOptions() {
        guard categoryOptionsResponse == nil else { return }
        dataModelDelegate?.refreshFilterSortUI(true)
        let dataTask = APIManager.shared.getFilterAndSortOptions(id: categoryObject.id, completion: { [weak self] (data) in
            defer {
                self?.dataModelDelegate?.refreshFilterSortUI(false)
            }
            guard let response = data else { return }
            self?.categoryOptionsResponse = response
            }, failure: { [weak self] (upError) in
                defer {
                    self?.dataModelDelegate?.handleCategoryItems(error: upError)
                }
        })
        addDataTask(dataTask: dataTask)
    }
}

//  App State Management

extension CategoryItemsDataModel {

    open override func appWillEnterForeground() {
        fetchCategoryOptions()
        
        if !categoryOptionsApplied {
            refreshData(true)
        } else if itemsArray == nil || itemsArray!.count == 0 {
            refreshData(false)
        }
        
        guard let item: Item = (tableView?.visibleCells.last as? ItemCellDelegate)?.object() else { return }
        if let subCategoriesArray = subCategoriesArray {
            if subCategoriesArray.last?.last === item, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
                fetchCategoryItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
            }
        } else {
            if itemsArray?.last === item, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
                fetchCategoryItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
            }
        }
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension CategoryItemsDataModel {

    open override func networkIsAvailable() {
        fetchCategoryOptions()
        if !categoryOptionsApplied {
            refreshData(true)
            return
        } else if itemsArray == nil || itemsArray!.count == 0 {
            refreshData(false)
            return
        }

        guard let item: Item = (tableView?.visibleCells.last as? ItemCellDelegate)?.object() else { return }
        if let subCategoriesArray = subCategoriesArray {
            if subCategoriesArray.last?.last === item, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
                fetchCategoryItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
            }
        } else {
            if itemsArray?.last === item, itemsArray!.count < categoryItemsResponse!.meta.totalCount {
                fetchCategoryItems(isForcedRefresh: true, next: categoryItemsResponse?.meta.next)
            }
        }
    }

}
