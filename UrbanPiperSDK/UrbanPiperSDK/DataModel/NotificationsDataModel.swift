//
//  NotificationsDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 30/10/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc public protocol NotificationsDataModelDelegate {

    func refreshNotificationsUI(_ isRefreshing: Bool)
    func handleNotifications(error: UPError?)

}

@objc public protocol NotificationCellDelegate {
    func configureCell(_ notification: Message?)
}

public class NotificationsDataModel: UrbanPiperDataModel {

    weak public var dataModelDelegate: NotificationsDataModelDelegate?

    var notificationsResponse: NotificationsResponse? {
        didSet {
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }

    public var notificationsListArray: [Message]? {
        return notificationsResponse?.messages
    }

    public override init() {
        super.init()

        refreshData(true)
    }

    public func refreshData(_ isForcedRefresh: Bool = false) {
        fetchNotificationsList(isForcedRefresh: isForcedRefresh)
    }

}

//  MARK: UITableView DataSource
extension NotificationsDataModel {

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationsListArray?.count ?? 0
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier!, for: indexPath)

        if let notificationCell: NotificationCellDelegate = cell as? NotificationCellDelegate {
            notificationCell.configureCell(notificationsListArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to NotificationCellDelegate protocol")
        }

        return cell
    }
}

//  MARK: UICollectionView DataSource

extension NotificationsDataModel {

    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return notificationsListArray?.count ?? 0
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier!, for: indexPath)

        if let notificationCell: NotificationCellDelegate = cell as? NotificationCellDelegate {
            notificationCell.configureCell(notificationsListArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to NotificationCellDelegate protocol")
        }

        return cell
    }

}

//  MARK: API Calls

extension NotificationsDataModel {

    fileprivate func fetchNotificationsList(isForcedRefresh: Bool) {
        dataModelDelegate?.refreshNotificationsUI(true)
        let dataTask: URLSessionDataTask = APIManager.shared.fetchNotificationsList(completion: { [weak self] (data) in
            defer {
                self?.dataModelDelegate?.refreshNotificationsUI(false)
            }
            guard let response = data else { return }
            self?.notificationsResponse = response
        }, failure: { [weak self] (upError) in
            defer {
                self?.dataModelDelegate?.handleNotifications(error: upError)
            }
        })

        addOrCancelDataTask(dataTask: dataTask)
    }
}

//  App State Management

extension NotificationsDataModel {

    open override func appWillEnterForeground() {
        refreshData(false)
    }

    @objc open override func appDidEnterBackground() {

    }

}

//  Reachability

extension NotificationsDataModel {

    open override func networkIsAvailable() {
        refreshData(false)
    }

}
