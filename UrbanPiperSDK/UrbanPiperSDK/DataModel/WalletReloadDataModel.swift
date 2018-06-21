//
//  WalletReloadDataModel.swift
//  UrbanPiperSDK
//
//  Created by Vidhyadharan Mohanram on 13/06/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import UIKit

@objc public protocol WalletReloadDataModelDelegate {

    func initiatingWalletReload(isProcessing: Bool)

    func verifyingWalletReloadTransaction(isProcessing: Bool)

    func initiatePayTMWebWalletReload(onlinePaymentInitResponse: OnlinePaymentInitResponse)

    func initiateRazorWalletReload(onlinePaymentInitResponse: OnlinePaymentInitResponse)

    func initiateSimplWalletReload(transactionId: String)

    func updateUserBizInfoBalance()

    func handleWalletReload(error: UPError?)
}


public class WalletReloadDataModel: UrbanPiperDataModel {

    weak public var dataModelDelegate: WalletReloadDataModelDelegate?

    var transactionId: String?

    public convenience init(delegate: WalletReloadDataModelDelegate) {
        self.init()

        dataModelDelegate = delegate
    }

    public func initiateWalletReload(amount: Decimal, paymentOption: PaymentOption = .paymentGateway) {
        transactionId = nil

        dataModelDelegate?.initiatingWalletReload(isProcessing: true)
        let dataTask = APIManager.shared.initiateOnlinePayment(paymentOption: paymentOption,
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
                self?.dataModelDelegate?.handleWalletReload(error: upError)
        });

        addOrCancelDataTask(dataTask: dataTask)
    }

}

extension WalletReloadDataModel {

    public func verifyWalletReloadTransaction(paymentId: String) {
        dataModelDelegate?.verifyingWalletReloadTransaction(isProcessing: true)

        let dataTask = APIManager.shared.verifyPayment(pid: paymentId,
                                                       orderId: OnlinePaymentPurpose.reload.rawValue,
                                                       transactionId: transactionId!,
                                                       completion: { [weak self] (responseDict) in
                                                        self?.dataModelDelegate?.verifyingWalletReloadTransaction(isProcessing: false)
                                                        if let status = responseDict?["status"] as? String, status == "3" {
                                                            self?.dataModelDelegate?.updateUserBizInfoBalance()
                                                        } else {
                                                            let upError = UPAPIError(responseObject: responseDict)
                                                            self?.dataModelDelegate?.handleWalletReload(error: upError)
                                                        }
            }, failure: { [weak self] (error) in
                self?.dataModelDelegate?.verifyingWalletReloadTransaction(isProcessing: false)
                self?.dataModelDelegate?.handleWalletReload(error: error)
        })

        transactionId = nil

        addOrCancelDataTask(dataTask: dataTask)
    }
}

//  App State Management

extension WalletReloadDataModel {

    @objc open override func appWillEnterForeground() {
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension WalletReloadDataModel {

    @objc open override func networkIsAvailable() {
    }

    @objc open override func networkIsDown() {

    }
}

