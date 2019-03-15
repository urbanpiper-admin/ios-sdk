//
//  CartDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 27/12/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc public protocol CartDataModelDelegate {
    func refreshCartUI()
//    func handleCart(error: CartError?)
}

@objc public protocol CartItemCellDelegate {
    func configureCell(_ cartItem: CartItem?, extras: Extras?)
}

open class CartDataModel: UrbanPiperDataModel {

    weak open var dataModelDelegate: CartDataModelDelegate?

    open var cartItemsListArray: [[CartItem]] = CartManager.shared.groupedCartItems

    public override init() {
        super.init()

        NotificationCenter.default.addObserver(self, selector: #selector(refreshCartUI), name: NSNotification.Name.cartChanged, object: nil)
//        CartManager.addObserver(delegate: self)
    }

    open func refreshData() {
        cartItemsListArray = CartManager.shared.groupedCartItems
        dataModelDelegate?.refreshCartUI()
        tableView?.reloadData()
        collectionView?.reloadData()
    }

}

//  MARK: UITableView DataSource
extension CartDataModel {

    open func numberOfSections(in tableView: UITableView) -> Int {
        return cartItemsListArray.count
    }

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItemsListArray[section].count
    }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier!, for: indexPath)

        if let cartItemCell: CartItemCellDelegate = cell as? CartItemCellDelegate {
            cartItemCell.configureCell(cartItemsListArray[indexPath.section][indexPath.row], extras: extras)
        } else {
            assert(false, "Cell does not conform to CartItemCellDelegate protocol")
        }

        return cell
    }
}

//  MARK: UICollectionView DataSource

extension CartDataModel {

    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartItemsListArray.count
    }

    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier!, for: indexPath)

        if let cartItemCell: CartItemCellDelegate = cell as? CartItemCellDelegate {
            cartItemCell.configureCell(cartItemsListArray[indexPath.section][indexPath.row], extras: extras)
        } else {
            assert(false, "Cell does not conform to CartItemCellDelegate protocol")
        }

        return cell
    }

}

extension CartDataModel: CartManagerDelegate {

    open func handleCart(error: CartError?) {
//        dataModelDelegate?.handleCart(error: error)
    }

    @objc open func refreshCartUI() {
        refreshData()
    }

}

//  App State Management

extension CartDataModel {

    open override func appWillEnterForeground() {
        guard cartItemsListArray.count == 0 else { return }
        refreshData()
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension CartDataModel {

    open override func networkIsAvailable() {
        guard cartItemsListArray.count == 0 else { return }
        refreshData()
    }

}
