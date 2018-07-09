//
//  ItemDetailsDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 30/10/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit


@objc public protocol ItemDetailsDataModelDelegate {

    func refreshItemDetailsUI()
    func handleItemDetails(error: UPError?)

}

public class ItemDetailsDataModel: UrbanPiperDataModel {

    weak public var dataModelDelegate: ItemDetailsDataModelDelegate?

    public var itemId: Int? {
        didSet {
            refreshData()
        }
    }

    public var item: ItemObject?
    public var userLikesResponse: UserLikesResponse?

    private override init() {
        super.init()
    }

    public convenience init(delegate: ItemDetailsDataModelDelegate) {
        self.init()

        dataModelDelegate = delegate
        
        refreshData()
    }

    public func refreshData(_ isForcedRefresh: Bool = false) {
        fetchItemLikes()

        guard let id = itemId else {
            dataModelDelegate?.handleItemDetails(error: nil)
            return
        }

        fetchItemDetails(itemId: id)
    }

}

//  MARK: API Calls

extension ItemDetailsDataModel {

    fileprivate func fetchItemLikes() {
        guard AppUserDataModel.shared.validAppUserData != nil else { return }

        let dataTask: URLSessionDataTask = APIManager.shared.userLikes(completion: { [weak self] (data) in
            defer {
                self?.dataModelDelegate?.refreshItemDetailsUI()
            }
            guard let response = data else { return }
            self?.userLikesResponse = response
            }, failure: { [weak self] (upError) in
                defer {
                    self?.dataModelDelegate?.handleItemDetails(error: upError)
                }
        })

        addOrCancelDataTask(dataTask: dataTask)
    }

    public func likeUnlikeItem(like: Bool) {
        guard let itemDetails = item, let userLikes = userLikesResponse else { return }

        let dataTask: URLSessionDataTask = APIManager.shared.likeUnlikeItem(itemId: itemDetails.id,
                                                        like: like, completion: { [weak self] (data) in
                                                            if let likeCount = self?.item?.likes {
                                                                if like {
                                                                    self?.item?.likes = likeCount + 1
                                                                } else {
                                                                    self?.item?.likes = likeCount - 1
                                                                }
                                                            }
                                                            self?.fetchItemLikes()
            }, failure: { [weak self] (upError) in
                defer {
                    self?.dataModelDelegate?.refreshItemDetailsUI()
                    self?.dataModelDelegate?.handleItemDetails(error: upError)
                }
        })
        
        addOrCancelDataTask(dataTask: dataTask)
    }

    fileprivate func fetchItemDetails(itemId: Int)  {

        let dataTask: URLSessionDataTask = APIManager.shared.fetchItemDetails(itemId: itemId,
                                                          locationID: OrderingStoreDataModel.shared.nearestStoreResponse?.store?.bizLocationId,
                                                          completion: { [weak self] (data) in
            defer {
                self?.dataModelDelegate?.refreshItemDetailsUI()
            }
            guard let response = data else { return }
            self?.item = response
        }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.handleItemDetails(error: upError)
            }
        })

        addOrCancelDataTask(dataTask: dataTask)
    }

}

//  App State Management

extension ItemDetailsDataModel {

    open override func appWillEnterForeground() {
        refreshData()
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension ItemDetailsDataModel {

    open override func networkIsAvailable() {
        refreshData()
    }

}
