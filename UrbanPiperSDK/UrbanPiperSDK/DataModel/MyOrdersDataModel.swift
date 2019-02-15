//
//  MyOrdersDataModel.swift
//  UrbanPiperSDK
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import UIKit

@objc public protocol OrderCellDelegate {
    func object() -> PastOrder?
    
    func configureCell(_ myOrder: PastOrder?, extras: Extras?)
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

    open var myOrdersResponse: PastOrdersResponse? {
        didSet {
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }
    
    public var myOrdersArray: [PastOrder] {
        return myOrdersResponse?.orders ?? []
    }

    public func refreshData() {
        fetchOrderHistory()
    }
}

//  MARK: UITableView DataSource
extension MyOrdersDataModel {
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrdersArray.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier!, for: indexPath)
        
        if let orderCell: OrderCellDelegate = cell as? OrderCellDelegate {
            let myOrder: PastOrder = myOrdersArray[indexPath.row]
            
            orderCell.configureCell(myOrder, extras: extras)
            if myOrdersArray.last === myOrder, myOrdersArray.count < myOrdersResponse!.meta.totalCount {
                fetchOrderHistory(next:  myOrdersResponse?.meta.next)
            }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier!, for: indexPath)
        
        if let orderCell: OrderCellDelegate = cell as? OrderCellDelegate {
            let myOrder: PastOrder = myOrdersArray[indexPath.row]
            
            orderCell.configureCell(myOrder, extras: extras)
            if myOrdersArray.last === myOrder, myOrdersArray.count < myOrdersResponse!.meta.totalCount {
                fetchOrderHistory(next:  myOrdersResponse?.meta.next)
            }
        } else {
            assert(false, "Cell does not conform to OrderCellDelegate protocol")
        }
        
        return cell
    }
    
}

//  Api Call

extension MyOrdersDataModel {

    public func fetchOrderHistory(next: String? = nil) {

        dataModelDelegate?.refreshMyOrdersUI(isProcessing: true)
        let dataTask: URLSessionDataTask = APIManager.shared.getOrderHistory(next: next,
                                                                               completion:
            { [weak self] (data) in
                defer {
                    self?.dataModelDelegate?.refreshMyOrdersUI(isProcessing: false)
                }
            guard let response = data else { return }
                
                if next == nil {
                    self?.myOrdersResponse = response
                } else {
                    let currentMyOrdersResponse = self?.myOrdersResponse
                    
                    currentMyOrdersResponse?.orders.append(contentsOf: response.orders)
                    currentMyOrdersResponse?.meta = response.meta

                    self?.myOrdersResponse = currentMyOrdersResponse
                }
        }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.handleMyOrders(error: upError)
            }
        })
        
        addDataTask(dataTask: dataTask)
    }

}

//  App State Management

extension MyOrdersDataModel {

    @objc open override func appWillEnterForeground() {
        if myOrdersArray.count == 0 {
            refreshData()
        }
        
        guard let myOrder: PastOrder = (tableView?.visibleCells.last as? OrderCellDelegate)?.object() else { return }
        if myOrdersArray.last === myOrder, myOrdersArray.count < myOrdersResponse!.meta.totalCount {
            fetchOrderHistory(next: myOrdersResponse?.meta.next)
        }

    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension MyOrdersDataModel {

    @objc open override func networkIsAvailable() {
        if myOrdersArray.count == 0 {
            refreshData()
        }
        
        guard let myOrder: PastOrder = (tableView?.visibleCells.last as? OrderCellDelegate)?.object() else { return }
        if myOrdersArray.last === myOrder, myOrdersArray.count < myOrdersResponse!.meta.totalCount {
            fetchOrderHistory(next: myOrdersResponse?.meta.next)
        }

    }

    @objc open override func networkIsDown() {

    }
}
