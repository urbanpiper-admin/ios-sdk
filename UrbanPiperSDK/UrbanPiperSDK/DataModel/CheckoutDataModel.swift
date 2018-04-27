//
//  CheckoutDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 27/12/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc public protocol CheckoutDataModelDelegate {
    func refreshCheckoutUI()
    func handleCheckout(error: UPError?)
}

@objc public protocol CheckoutItemCellDelegate {
    func configureCell(_ checkoutItemsObject: ItemObject?)
}

open class CheckoutDataModel: UrbanPiperDataModel {

    weak open var dataModelDelegate: CheckoutDataModelDelegate?

    open var checkoutItemsListArray: [[ItemObject]] = CartManager.shared.groupedCartItems

    public override init() {
        super.init()

        CartManager.addObserver(delegate: self)
    }

    open func refreshData() {
        checkoutItemsListArray = CartManager.shared.groupedCartItems
        dataModelDelegate?.refreshCheckoutUI()
        tableView?.reloadData()
        collectionView?.reloadData()
    }

}

//  MARK: UITableView DataSource
extension CheckoutDataModel {

    open func numberOfSections(in tableView: UITableView) -> Int {
        return checkoutItemsListArray.count
    }

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkoutItemsListArray[section].count
    }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)

        if let checkoutItemCell = cell as? CheckoutItemCellDelegate {
            checkoutItemCell.configureCell(checkoutItemsListArray[indexPath.section][indexPath.row])
        } else {
            assert(false, "Cell does not conform to CheckoutItemCellDelegate protocol")
        }

        return cell
    }
}

//  MARK: UICollectionView DataSource

extension CheckoutDataModel {

    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return checkoutItemsListArray.count
    }

    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier!, for: indexPath)

        if let checkoutItemCell = cell as? CheckoutItemCellDelegate {
            checkoutItemCell.configureCell(checkoutItemsListArray[indexPath.section][indexPath.row])
        } else {
            assert(false, "Cell does not conform to CheckoutItemCellDelegate protocol")
        }

        return cell
    }

}

extension CheckoutDataModel: CartManagerDelegate {

    open func handleCart(error: UPError?) {
        dataModelDelegate?.handleCheckout(error: error)
    }

    open func refreshCartUI() {
        refreshData()
    }

}

//  App State Management

extension CheckoutDataModel {

    open override func appWillEnterForeground() {
        guard checkoutItemsListArray.count == 0 else { return }
        refreshData()
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension CheckoutDataModel {

    open override func networkIsAvailable() {
        guard checkoutItemsListArray.count == 0 else { return }
        refreshData()
    }

}
