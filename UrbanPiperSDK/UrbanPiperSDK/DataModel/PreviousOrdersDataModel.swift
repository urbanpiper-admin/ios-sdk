//
//  PreviousOrdersDataModel.swift
//  UrbanPiperSDK
//
//  Created by Vid on 19/07/18.
//

import UIKit

@objc public protocol PreviousOrdersDataModelDelegate {
    
    func refreshPreviousOrdersUI(isProcessing: Bool)
    
    func handlePreviousOrders(error: UPError?)
}

open class PreviousOrdersDataModel: UrbanPiperDataModel {

    public static var previousOrdersFetchlimit: Int = 3

    weak public var dataModelDelegate: PreviousOrdersDataModelDelegate? {
        didSet {
            refreshData()
        }
    }
    
    open var myOrdersResponse: MyOrdersResponse? {
        didSet {
            guard myOrdersResponse != nil else { return }
            fetchAllOrderDetails()
        }
    }
    
    public var myOrdersArray: [MyOrder]? {
        return myOrdersResponse?.orders
    }
    
    var isOrderDetailsFetchCompleted: Bool {
        guard myOrdersArray?.filter ({ $0.myOrderDetailsResponse == nil }).count == 0 else { return false }
        return true
    }
    
    public override init() {
        super.init()
        
        AppUserDataModel.shared.addObserver(delegate: self)
    }
    
    func refreshData() {
        fetchOrderHistory()
    }
}

extension PreviousOrdersDataModel: AppUserDataModelDelegate {
    
    public func refreshAppUserUI(isRefreshing: Bool) {
        fetchOrderHistory()
    }
    
    public func handleUserAPI(error: UPError?) {
        
    }
}

//  MARK: UITableView DataSource
extension PreviousOrdersDataModel {
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrdersArray?.count ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier!, for: indexPath)
        
        if let orderCell: OrderCellDelegate = cell as? OrderCellDelegate {
            orderCell.configureCell(myOrdersArray![indexPath.row])
        } else {
            assert(false, "Cell does not conform to OrderCellDelegate protocol")
        }
        
        return cell
    }
}

//  MARK: UICollectionView DataSource

extension PreviousOrdersDataModel {
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myOrdersArray?.count ?? 0
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier!, for: indexPath)
        
        if let orderCell: OrderCellDelegate = cell as? OrderCellDelegate {
            orderCell.configureCell(myOrdersArray![indexPath.row])
        } else {
            assert(false, "Cell does not conform to OrderCellDelegate protocol")
        }
        
        return cell
    }
    
}

//  Api Call

extension PreviousOrdersDataModel {
    
    public func fetchOrderHistory() {
        guard AppUserDataModel.shared.validAppUserData != nil else {
            myOrdersResponse = nil
            dataModelDelegate?.refreshPreviousOrdersUI(isProcessing: false)
            return
        }
        
        dataModelDelegate?.refreshPreviousOrdersUI(isProcessing: true)
        let dataTask: URLSessionDataTask = APIManager.shared.fetchOrderHistory(limit: PreviousOrdersDataModel.previousOrdersFetchlimit,
                                                                               completion:
            { [weak self] (data) in
                guard let response = data else {
                    self?.dataModelDelegate?.refreshPreviousOrdersUI(isProcessing: false)
                    return
                }
                self?.myOrdersResponse = response
            }, failure: { [weak self] (upError) in
                defer {
                    self?.dataModelDelegate?.handlePreviousOrders(error: upError)
                }
                self?.dataModelDelegate?.refreshPreviousOrdersUI(isProcessing: false)
        })

        addOrCancelDataTask(dataTask: dataTask)
    }
    
    func fetchAllOrderDetails() {
        for myOrder: MyOrder in myOrdersArray! {
            fetchOrderDetails(orderId: myOrder.id)
        }
    }
    
    public func fetchOrderDetails(orderId: Int) {
        let lock = self

        dataModelDelegate?.refreshPreviousOrdersUI(isProcessing: true)
        let dataTask: URLSessionDataTask = APIManager.shared.fetchOrderDetails(orderId: orderId,
                                                                               completion:
            { [weak self] (data) in
                guard let response = data else { return }
                objc_sync_enter(lock)
                let order: MyOrder? = self?.myOrdersArray?.filter ({ $0.id == response.order.details.id }).last
                order?.myOrderDetailsResponse = response
                if let completed: Bool = self?.isOrderDetailsFetchCompleted, completed {
                    self?.completedOrderDetailsFetch()
                }
                objc_sync_exit(lock)
                
            }, failure: { [weak self] (upError) in
                defer {
                    self?.dataModelDelegate?.handlePreviousOrders(error: upError)
                }
                self?.dataModelDelegate?.refreshPreviousOrdersUI(isProcessing: false)
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    func completedOrderDetailsFetch() {
        tableView?.reloadData()
        collectionView?.reloadData()
        
        dataModelDelegate?.refreshPreviousOrdersUI(isProcessing: false)
    }
    
}

//  App State Management

extension PreviousOrdersDataModel {
    
    @objc open override func appWillEnterForeground() {
        if myOrdersArray == nil || myOrdersArray!.count == 0 {
            refreshData()
        }
    }
    
    @objc open override func appDidEnterBackground() {
        
    }
    
}

//  Reachability

extension PreviousOrdersDataModel {
    
    @objc open override func networkIsAvailable() {
        if myOrdersArray == nil || myOrdersArray!.count == 0 {
            refreshData()
        }
    }
    
    @objc open override func networkIsDown() {
        
    }
}

