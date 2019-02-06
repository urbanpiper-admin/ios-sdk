//
//  BannersDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 30/10/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc public protocol BannersDataModelDelegate {

    func refreshBannersUI(isRefreshing: Bool)
    func handleBanners(error: UPError?)

}

@objc public protocol BannerCellDelegate {
    func configureCell(_ bannersImage: BannerImage?, extras: Extras?)
}

public class BannersDataModel: UrbanPiperDataModel {

    weak public var dataModelDelegate: BannersDataModelDelegate?

    private typealias WeakRefDataModelDelegate = WeakRef<BannersDataModelDelegate>
    
    private var observers = [WeakRefDataModelDelegate]()

    public var bannersResponse: BannersResponse? {
        didSet {
            tableView?.reloadData()
            collectionView?.reloadData()

            guard let count: Int = bannersResponse?.images.count, count > 1 else { return }
            
            DispatchQueue.main.async { [weak self] in
                let indexPath: IndexPath = IndexPath(row: 1, section: 0)

                self?.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
        }
    }

    public var bannersListArray: [BannerImage]? {
        return bannersResponse?.images
    }

    public override init() {
        super.init()
    }
    
    public convenience init(delegate: BannersDataModelDelegate) {
        self.init()
        
        dataModelDelegate = delegate
    }
    
    @objc public func addObserver(delegate: BannersDataModelDelegate) {
        let weakRefDataModelDelegate: WeakRefDataModelDelegate = WeakRefDataModelDelegate(value: delegate)
        observers.append(weakRefDataModelDelegate)
        observers = observers.filter { $0.value != nil }
    }
    
    
    public func removeObserver(delegate: BannersDataModelDelegate) {
        guard let index = (observers.index { $0.value === delegate }) else { return }
        observers.remove(at: index)
    }


    public func refreshData(_ isForcedRefresh: Bool = false) {
        guard AppConfigManager.shared.firRemoteConfigDefaults.showBanners else { return }
        fetchBannersList()
    }
}

//  MARK: UITableView DataSource
extension BannersDataModel {

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bannersListArray?.count ?? 0
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier!, for: indexPath)

        if let bannerCell: BannerCellDelegate = cell as? BannerCellDelegate {
            bannerCell.configureCell(bannersListArray?[indexPath.row], extras: extras)
        } else {
            assert(false, "Cell does not conform to BannerCellDelegate protocol")
        }

        return cell
    }
}

//  MARK: UICollectionView DataSource

extension BannersDataModel {

    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = bannersResponse?.images?.count {
            guard count > 1 else { return count }
            return count + 2
        } else {
            return 0
        }
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier!, for: indexPath)

        if let bannerCell: BannerCellDelegate = cell as? BannerCellDelegate {
            let image: BannerImage?

            if let images = bannersListArray {
                if indexPath.row == 0 {
                    image = images.last
                } else if indexPath.row > bannersListArray!.count {
                    image = images.first
                } else {
                    image = images[indexPath.row - 1]
                }
            } else {
                image = nil
            }

            bannerCell.configureCell(image, extras: extras)
        } else {
            assert(false, "Cell does not conform to BannerCellDelegate protocol")
        }

        return cell
    }

}

//  MARK: API Calls

extension BannersDataModel {

    fileprivate func fetchBannersList() {
        guard AppConfigManager.shared.firRemoteConfigDefaults.showBanners else { return }
        
        dataModelDelegate?.refreshBannersUI(isRefreshing: true)
        let _ = observers.map { $0.value?.refreshBannersUI(isRefreshing: true) }
        let dataTask: URLSessionDataTask = APIManager.shared.fetchBannersList(completion: { [weak self] (data) in
            defer {
                self?.dataModelDelegate?.refreshBannersUI(isRefreshing: false)
                let _ = self?.observers.map { $0.value?.refreshBannersUI(isRefreshing: false) }

            }
            guard let response = data else { return }
            self?.bannersResponse = response
        }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.handleBanners(error: upError)
                let _ = self?.observers.map { $0.value?.handleBanners(error: upError) }
            }
        })
        addDataTask(dataTask: dataTask)
    }
}

//  App State Management

extension BannersDataModel {

    open override func appWillEnterForeground() {
        guard bannersResponse == nil else { return }
        refreshData()
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension BannersDataModel {

    open override func networkIsAvailable() {
        guard bannersResponse == nil else { return }
        refreshData()
    }

}
