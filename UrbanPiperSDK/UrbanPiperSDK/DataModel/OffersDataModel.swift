//
//  OffersDataModel.swift
//  UrbanPiperSDK
//
//  Created by Vid on 10/07/18.
//

import UIKit

@objc public protocol OffersDataModelDelegate {
        
    func refreshCouponUI(_ isRefreshing: Bool)

//    func refreshApplyCouponUI(_ isRefreshing: Bool)

    func handleCoupon(error: UPError?)
}

@objc public protocol OfferCellDelegate {
    func configureCell(_ coupon: Coupon?)
    
    func object() -> Coupon?
}

open class OffersDataModel: UrbanPiperDataModel {
    
    weak public var dataModelDelegate: OffersDataModelDelegate?
    
    public var offersAPIResponse: OffersAPIResponse? {
        didSet {
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }
    
    public var couponCodesArray: [Coupon]? {
        return offersAPIResponse?.coupons ?? []
    }
    
    public var appliedCouponCode: String?
    public var applyCouponResponse: Order?
    
    public override init() {
        super.init()
        
        refreshData()
    }

    open func refreshData(_ isForcedRefresh: Bool = false) {
        availableCoupons(isForcedRefresh: isForcedRefresh)
    }

    
    public func availableCoupons(next: String? = nil, isForcedRefresh: Bool = false) {
        guard isForcedRefresh || (!isForcedRefresh && offersAPIResponse == nil) else { return }
        dataModelDelegate?.refreshCouponUI(true)
        let dataTask: URLSessionDataTask = APIManager.shared.availableCoupons(next: next,
                                                                         completion: { [weak self] (offersAPIResponse) in
                                                                            defer {
                                                                                self?.dataModelDelegate?.refreshCouponUI(false)
                                                                            }
                                                                            guard let response = offersAPIResponse else { return }

                                                                            if next == nil {
                                                                                self?.offersAPIResponse = offersAPIResponse
                                                                            } else {
                                                                                let currentOffersAPIResponse = self?.offersAPIResponse
                                                                                
                                                                                currentOffersAPIResponse?.coupons.append(contentsOf: response.coupons)
                                                                                currentOffersAPIResponse?.meta = response.meta
                                                                                
                                                                                self?.offersAPIResponse = currentOffersAPIResponse
                                                                            }
            }, failure: { [weak self] (upError) in
                defer {
                    self?.dataModelDelegate?.refreshCouponUI(false)
                    self?.dataModelDelegate?.handleCoupon(error: upError)
                }
        })
        addOrCancelDataTask(dataTask: dataTask)
    }
    
//    public func applyCoupon(code: String,
//                            deliveryOption: DeliveryOption,
//                            applyWalletCredits: Bool) {
//        guard code.count > 0 else { return }
//        let orderDict: [String: Any] = ["biz_location_id": OrderingStoreDataModel.shared.orderingStore!.bizLocationId,
//                                        "order_type": deliveryOption.rawValue,
//                                        "channel": APIManager.channel,
//                                        "items": CartManager.shared.cartItems.map { $0.discountCouponApiItemDictionary },
//                                        "apply_wallet_credit": applyWalletCredits] as [String : Any]
//
//        dataModelDelegate?.refreshApplyCouponUI(true)
//        let dataTask: URLSessionDataTask = APIManager.shared.applyCoupon(code: code,
//                                                                         orderData: orderDict,
//                                                                         completion: { [weak self] (applyCouponResponse) in
//                                                                            defer {
//                                                                                self?.appliedCouponCode = code
//                                                                                self?.dataModelDelegate?.refreshApplyCouponUI(false)
//                                                                            }
//
//                                                                            self?.applyCouponResponse = applyCouponResponse
//            }, failure: { [weak self] (upError) in
//                defer {
//                    self?.dataModelDelegate?.refreshApplyCouponUI(false)
//                    self?.dataModelDelegate?.handleCoupon(error: upError)
//                }
//        })
//        addOrCancelDataTask(dataTask: dataTask)
//    }

}

//  MARK: UITableView DataSource
extension OffersDataModel {
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couponCodesArray?.count ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier!, for: indexPath)
        
        if let couponCell: OfferCellDelegate = cell as? OfferCellDelegate {
            let coupon: Coupon = couponCodesArray![indexPath.row]
            if couponCodesArray!.last === coupon, couponCodesArray!.count < offersAPIResponse!.meta.totalCount {
                    availableCoupons(next: offersAPIResponse?.meta.next, isForcedRefresh: true)
                }
            couponCell.configureCell(coupon)
        } else {
            assert(false, "Cell does not conform to OfferCellDelegate protocol")
        }
        
        return cell
    }
    
}

//  MARK: UICollectionView DataSource

extension OffersDataModel {
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return couponCodesArray?.count ?? 0
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier!, for: indexPath)
        
        if let couponCell: OfferCellDelegate = cell as? OfferCellDelegate {
            couponCell.configureCell(couponCodesArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to OfferCellDelegate protocol")
        }
        
        return cell
    }
    
}

//  App State Management

extension OffersDataModel {
    
    open override func appWillEnterForeground() {
        guard couponCodesArray == nil || couponCodesArray?.count == 0 else { return }
        refreshData(false)
        
        guard let coupon: Coupon = (tableView?.visibleCells.last as? OfferCellDelegate)?.object() else { return }
        if couponCodesArray?.last === coupon, couponCodesArray!.count < offersAPIResponse!.meta.totalCount {
            availableCoupons(next: offersAPIResponse?.meta.next)
        }
    }
    
    @objc open override func appDidEnterBackground() {
        
    }
    
}

//  Reachability

extension OffersDataModel {
    
    open override func networkIsAvailable() {
        if couponCodesArray == nil || couponCodesArray?.count == 0 {
            refreshData(false)
        }
        
        guard let coupon: Coupon = (tableView?.visibleCells.last as? OfferCellDelegate)?.object() else { return }
        if couponCodesArray?.last === coupon, couponCodesArray!.count < offersAPIResponse!.meta.totalCount {
            availableCoupons(next: offersAPIResponse?.meta.next)
        }
    }
    
}

