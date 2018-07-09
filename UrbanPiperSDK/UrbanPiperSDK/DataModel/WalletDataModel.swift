//
//  WalletDataModel.swift
//  UrbanPiperSDK
//
//  Created by Vidhyadharan Mohanram on 13/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import UIKit

@objc public protocol WalletDataModelDelegate {

    func fetchingWalletTransactions(isRefreshing: Bool)
    
    func initiatingWalletReload(isProcessing: Bool)

    func verifyingWalletReloadTransaction(isProcessing: Bool)

    func initiatePayTMWebWalletReload(onlinePaymentInitResponse: OnlinePaymentInitResponse)

    func initiateRazorWalletReload(onlinePaymentInitResponse: OnlinePaymentInitResponse)

    func initiateSimplWalletReload(transactionId: String)

    func updateUserBizInfoBalance()

    func handleWallet(error: UPError?)
}

@objc public protocol TransactionCellDelegate {
    func configureCell(_ transaction: Transaction?)
}


public class WalletDataModel: UrbanPiperDataModel {

    weak public var dataModelDelegate: WalletDataModelDelegate?

    var transactionId: String?
    
    var walletTransactionResponse: WalletTransactionResponse? {
        didSet {
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }
    
    public var transactionsListArray: [Transaction]? {
        return walletTransactionResponse?.transactions
    }

    public convenience init(delegate: WalletDataModelDelegate) {
        self.init()

        dataModelDelegate = delegate
    }
    
}

//  MARK: UITableView DataSource
extension WalletDataModel {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsListArray?.count ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier!, for: indexPath)
        
        if let transactionCell: TransactionCellDelegate = cell as? TransactionCellDelegate {
            transactionCell.configureCell(transactionsListArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to TransactionCellDelegate protocol")
        }
        
        return cell
    }
}

//  MARK: UICollectionView DataSource

extension WalletDataModel {
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transactionsListArray?.count ?? 0
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier!, for: indexPath)
        
        if let transactionCell: TransactionCellDelegate = cell as? TransactionCellDelegate {
            transactionCell.configureCell(transactionsListArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to TransactionCellDelegate protocol")
        }
        
        return cell
    }
    
}

extension WalletDataModel {
    
    public func fetchWalletTransactions() {
        dataModelDelegate?.fetchingWalletTransactions(isRefreshing: true)
        
        let dataTask: URLSessionDataTask = APIManager.shared.fetchWalletTransactions(completion: { [weak self] (response) in
            self?.walletTransactionResponse = response
            self?.dataModelDelegate?.fetchingWalletTransactions(isRefreshing: false)
        }, failure: { [weak self] (upError) in
            self?.dataModelDelegate?.handleWallet(error: upError)
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }

    public func initiateWalletReload(amount: Decimal, paymentOption: PaymentOption = .paymentGateway) {
        transactionId = nil

        dataModelDelegate?.initiatingWalletReload(isProcessing: true)
        let dataTask: URLSessionDataTask? = APIManager.shared.initiateOnlinePayment(paymentOption: paymentOption,
                                                               purpose: .reload,
                                                               totalAmount: amount,
                                                               bizLocationId: nil,
                                                               completion: { [weak self] (onlinePaymentInitResponse) in
                                                                self?.dataModelDelegate?.initiatingWalletReload(isProcessing: false)

                                                                self?.transactionId = onlinePaymentInitResponse!.transactionId
                                                                if paymentOption == .paymentGateway {
                                                                    self?.dataModelDelegate?.initiateRazorWalletReload(onlinePaymentInitResponse: onlinePaymentInitResponse!)
                                                                } else if paymentOption == .paytm {
                                                                    self?.dataModelDelegate?.initiatePayTMWebWalletReload(onlinePaymentInitResponse: onlinePaymentInitResponse!)
                                                                } else if paymentOption == .simpl {
                                                                    self?.dataModelDelegate?.initiateSimplWalletReload(transactionId: onlinePaymentInitResponse!.transactionId)
                                                                }
            }, failure: { [weak self] (upError) in
                self?.dataModelDelegate?.initiatingWalletReload(isProcessing: false)
                self?.dataModelDelegate?.handleWallet(error: upError)
        });

        addOrCancelDataTask(dataTask: dataTask)
    }

}

extension WalletDataModel {

    public func verifyWalletReloadTransaction(paymentId: String) {
        dataModelDelegate?.verifyingWalletReloadTransaction(isProcessing: true)

        let dataTask: URLSessionDataTask = APIManager.shared.verifyPayment(pid: paymentId,
                                                       orderId: OnlinePaymentPurpose.reload.rawValue,
                                                       transactionId: transactionId!,
                                                       completion: { [weak self] (responseDict) in
                                                        self?.dataModelDelegate?.verifyingWalletReloadTransaction(isProcessing: false)
                                                        if let status: String = responseDict?["status"] as? String, status == "3" {
                                                            self?.dataModelDelegate?.updateUserBizInfoBalance()
                                                        } else {
                                                            let apiError: UPAPIError? = UPAPIError(responseObject: responseDict)
                                                            self?.dataModelDelegate?.handleWallet(error: apiError)
                                                        }
            }, failure: { [weak self] (error) in
                self?.dataModelDelegate?.verifyingWalletReloadTransaction(isProcessing: false)
                self?.dataModelDelegate?.handleWallet(error: error)
        })

        transactionId = nil

        addOrCancelDataTask(dataTask: dataTask)
    }
}

//  App State Management

extension WalletDataModel {

    @objc open override func appWillEnterForeground() {
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension WalletDataModel {

    @objc open override func networkIsAvailable() {
    }

    @objc open override func networkIsDown() {

    }
}
