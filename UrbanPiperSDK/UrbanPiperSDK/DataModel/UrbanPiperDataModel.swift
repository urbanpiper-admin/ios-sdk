//
//  UrbanPiperDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 08/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

open class UrbanPiperDataModel: NSObject {

    typealias WeakRefURLSessionDataTask = WeakRef<URLSessionDataTask>

    var dataTasks = [WeakRefURLSessionDataTask]()

    public private(set) weak var collectionView: UICollectionView?
    
    public private(set) weak var tableView: UITableView?
    
    public private(set) var tableViewCellIdentifier: String!
    
    public private(set) var collectionViewCellIdentifier: String!
    
    public override init() {
        super.init()

        NotificationCenter.default.addObserver(forName: .UIApplicationWillEnterForeground, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.appWillEnterForeground()
        }

        NotificationCenter.default.addObserver(forName: .UIApplicationDidEnterBackground, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.appDidEnterBackground()
        }

        NotificationCenter.default.addObserver(forName: Notification.Name("UPReachabilityChanged"), object: nil, queue: OperationQueue.main) { [weak self] (notification) in
            self?.reachabilityChanged(notification)
        }

    }
    
    public convenience init(tableView: UITableView, cellIdentifier: String) {
        self.init()
        
        configure(tableView: tableView, cellIdentifier: cellIdentifier)
    }
    
    public convenience init(collectionView: UICollectionView, cellIdentifier: String) {
        self.init()
        
        configure(collectionView: collectionView, cellIdentifier: cellIdentifier)
    }
    
    open func configure(tableView: UITableView, cellIdentifier: String) {
        guard tableView.dequeueReusableCell(withIdentifier: cellIdentifier) != nil else {
            assert(false, "Provide a valid table view cell identifier")
            return
        }
        
        tableViewCellIdentifier = cellIdentifier
        tableView.dataSource = self
        
        self.tableView = tableView
        
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
    open func configure(collectionView: UICollectionView, cellIdentifier: String) {
        collectionViewCellIdentifier = cellIdentifier
        collectionView.dataSource = self
        
        self.collectionView = collectionView
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }

    deinit {
        _ = dataTasks.map { $0.value?.cancel }
        dataTasks.removeAll()
    }
        
    open func addOrCancelDataTask(dataTask :URLSessionDataTask?) {
        cleanDataTasksArray()
        guard let task = dataTask else { return }
        guard dataTasks.filter ({ $0.value?.originalRequest?.url == task.originalRequest?.url }).count == 0 else {
            task.cancel()
            return
        }
        dataTasks.append(WeakRefURLSessionDataTask(value: task))
        task.resume()
    }

    open func cleanDataTasksArray() {
        dataTasks = dataTasks.filter { $0.value != nil }
        dataTasks = dataTasks.filter { $0.value!.state == .suspended || $0.value!.state == .running }
    }
}

//  CollectionView DataSource

extension UrbanPiperDataModel: UICollectionViewDataSource {
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("Subopen class must override method \"collectionView(_: numberOfItemsInSection)\"")
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("Subopen class must override method \"collectionView(_: cellForItemAtIndexPath)\"")
    }
    
}

//  UITableView DataSource

extension UrbanPiperDataModel: UITableViewDataSource {
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Subopen class must override method \"tableView(_: numberOfRowsInSection)\"")
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Subopen class must override method \"tableView(_: cellForRowAtIndexPath)\"")
    }
    
}

//  App State Management

extension UrbanPiperDataModel {

    @objc open func appWillEnterForeground() {
        fatalError("Subopen class must override method \"appWillEnterForeground\"")
    }

    @objc open func appDidEnterBackground() {
        fatalError("Subopen class must override method \"appDidEnterBackground\"")
    }
}

//  Reachability

extension UrbanPiperDataModel {

    @objc fileprivate func reachabilityChanged(_ note: Notification) {

        guard let reachability = APIManager.reachability else { return }

        switch reachability.connection {
        case .wifi, .cellular:
            networkIsAvailable()
        case .none:
            networkIsDown()
        }
    }

    @objc open func networkIsAvailable() {
        fatalError("Subopen class must override method \"networkIsAvailable\"")
    }

    @objc open func networkIsDown() {

    }
}
