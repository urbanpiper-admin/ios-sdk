//
//  MyOrderDetailsDataModel.swift
//  UrbanPiperSDK
//
//  Created by Vidhyadharan Mohanram on 14/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import UIKit


@objc public protocol MyOrderDetailsDataModelDelegate {

    func refreshOrdersDetailsUI(isProcessing: Bool)

    func handleOrderDetails(error: UPError?)
}

open class MyOrderDetailsDataModel: UrbanPiperDataModel {

    weak public var dataModelDelegate: MyOrderDetailsDataModelDelegate?
    
    public var orderId: Int? {
        didSet {
            refreshData()
        }
    }

    open var myOrderDetailsResponse: PastOrderDetailsResponse?
    
    func refreshData() {
        fetchOrderDetails()
    }
}

//  Api Call

extension MyOrderDetailsDataModel {

    public func fetchOrderDetails() {
        guard orderId != nil else { return }

        dataModelDelegate?.refreshOrdersDetailsUI(isProcessing: true)
        let dataTask: URLSessionDataTask = APIManager.shared.getPastOrderDetails(orderId: orderId!,
                                                                               completion:
            { [weak self] (data) in
                defer {
                    self?.dataModelDelegate?.refreshOrdersDetailsUI(isProcessing: false)
                }
                guard let response = data else { return }
                self?.myOrderDetailsResponse = response
        }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.handleOrderDetails(error: upError)
            }
            self?.dataModelDelegate?.refreshOrdersDetailsUI(isProcessing: false)
        })
        
        addDataTask(dataTask: dataTask)
    }

}

//  App State Management

extension MyOrderDetailsDataModel {

    @objc open override func appWillEnterForeground() {
        guard myOrderDetailsResponse == nil else { return }
        refreshData()
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension MyOrderDetailsDataModel {

    @objc open override func networkIsAvailable() {
        guard myOrderDetailsResponse == nil else { return }
        refreshData()
    }

    @objc open override func networkIsDown() {

    }
}
