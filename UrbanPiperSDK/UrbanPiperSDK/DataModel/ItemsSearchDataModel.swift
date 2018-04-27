//
//  ItemsSearchDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 12/12/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc public protocol ItemsSearchDataModelDelegate {

    func refreshItemsSearchUI(_ isRefreshing: Bool)
    func handleItemsSearch(error: UPError?)

}

open class ItemsSearchDataModel: UrbanPiperDataModel {
    
    weak open var dataModelDelegate: ItemsSearchDataModelDelegate?

    private var keyword = ""

    open var itemsSearchResponse: ItemsSearchResponse? {
        didSet {
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }

    open var itemsArray: [ItemObject]? {
        return itemsSearchResponse?.items
    }

    open func refreshData(_ isForcedRefresh: Bool = false) {
        fetchItems(for: keyword)
    }

}

//  MARK: UITableView DataSource
extension ItemsSearchDataModel {

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray?.count ?? 0
    }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)

        if let categoryCell = cell as? ItemCellDelegate {
            categoryCell.configureCell(itemsArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to ItemCellDelegate protocol")
        }

        return cell
    }
}

//  MARK: UICollectionView DataSource

extension ItemsSearchDataModel {

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

extension ItemsSearchDataModel {

    open func fetchItems(for keyword: String = "") {
        for task in dataTasks {
            task.value?.cancel()
        }
        cleanDataTasksArray()

        NSObject.cancelPreviousPerformRequests(withTarget: self)

        guard keyword.count > 2 else {
            itemsSearchResponse = nil
            dataModelDelegate?.refreshItemsSearchUI(false)
            return
        }

        perform(#selector(searchItems(for:)), with: keyword, afterDelay: 1.0)
    }

    @objc private func searchItems(for keyword: String) {
        dataModelDelegate?.refreshItemsSearchUI(true)
        let dataTask = APIManager.shared.fetchCategoryItems(for: keyword,
                                                            locationID: OrderingStoreDataModel.nearestStoreResponse?.store?.bizLocationId,
                                                            completion: { [weak self] (data) in
                                                                defer {
                                                                    self?.dataModelDelegate?.refreshItemsSearchUI(false)
                                                                }
                                                                self?.keyword = ""
                                                                guard let response = data else { return }
                                                                self?.itemsSearchResponse = response
            }, failure: { [weak self] (upError) in
                defer {
                    self?.dataModelDelegate?.handleItemsSearch(error: upError)
                }
                self?.keyword = keyword
        })

        addOrCancelDataTask(dataTask: dataTask)
    }

}


//  App State Management

extension ItemsSearchDataModel {

    open override func appWillEnterForeground() {
        guard keyword.count > 0 else { return }
        refreshData(false)
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension ItemsSearchDataModel {

    open override func networkIsAvailable() {
        guard keyword.count > 0 else { return }
        refreshData(false)
    }

}
