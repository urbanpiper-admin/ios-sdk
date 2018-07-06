//
//  MyOrdersDataModel.swift
//  UrbanPiperSDK
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import UIKit

@objc public protocol OrderCellDelegate {
    func configureCell(_ order: MyOrderObject)
}

@objc public protocol MyOrdersDataModelDelegate {

    func refreshMyOrdersUI(isProcessing: Bool)

    func handleMyOrders(error: UPError?)
}

open class MyOrdersDataModel: UrbanPiperDataModel {

    weak public var dataModelDelegate: MyOrdersDataModelDelegate? {
        didSet {
            refreshData()
        }
    }

    open var myOrdersResponse: MyOrdersResponse? {
        didSet {
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }
    
    var myOrdersArray: [MyOrderObject] {
        return myOrdersResponse?.objects ?? []
    }

    func refreshData() {
        fetchOrderHistory()
    }
}

//  MARK: UITableView DataSource
extension MyOrdersDataModel {
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrdersArray.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)
        
        if let orderCell: OrderCellDelegate = cell as? OrderCellDelegate {
            orderCell.configureCell(myOrdersArray[indexPath.row])
        } else {
            assert(false, "Cell does not conform to OrderCellDelegate protocol")
        }
        
        return cell
    }
}

//  MARK: UICollectionView DataSource

extension MyOrdersDataModel {
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myOrdersArray.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier!, for: indexPath)
        
        if let orderCell: OrderCellDelegate = cell as? OrderCellDelegate {
            orderCell.configureCell(myOrdersArray[indexPath.row])
        } else {
            assert(false, "Cell does not conform to OrderCellDelegate protocol")
        }
        
        return cell
    }
    
}

//  Api Call

extension MyOrdersDataModel {

    public func fetchOrderHistory() {

        dataModelDelegate?.refreshMyOrdersUI(isProcessing: true)
        let dataTask: URLSessionTask = APIManager.shared.fetchOrderHistory(completion: { [weak self] (data) in
            self?.dataModelDelegate?.refreshMyOrdersUI(isProcessing: false)
            guard let response = data else { return }
            self?.myOrdersResponse = response
        }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.handleMyOrders(error: upError)
            }
            self?.dataModelDelegate?.refreshMyOrdersUI(isProcessing: false)
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }

}

//  App State Management

extension MyOrdersDataModel {

    @objc open override func appWillEnterForeground() {
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension MyOrdersDataModel {

    @objc open override func networkIsAvailable() {
    }

    @objc open override func networkIsDown() {

    }
}
