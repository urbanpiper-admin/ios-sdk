//
//  UrbanPiperDataModel.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 08/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

open class UrbanPiperDataModel: NSObject {

    typealias WeakRefURLSessionTask = WeakRef<URLSessionTask>

    var dataTasks = [WeakRefURLSessionTask]()

    public private(set) weak var collectionView: UICollectionView?
    
    public private(set) weak var tableView: UITableView?
    
    public private(set) var tableViewCellIdentifier: String!
    
    public private(set) var collectionViewCellIdentifier: String!
    
    public private(set) var identifier: String?
    
    public var cellIdentifier: String? {
        get {
            guard identifier == nil else { return identifier }
            
            if tableView != nil {
                guard tableView?.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) != nil else {
                    print("Provide a valid table view cell identifier")
                    return nil
                }
                
                identifier = tableViewCellIdentifier
            }
            
            if collectionView != nil {
                guard collectionView?.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: IndexPath(row: 0, section: 0)) != nil else {
                    print("Provide a valid collection view cell identifier")
                    return nil
                }
                
                identifier = collectionViewCellIdentifier
            }
            
            return identifier
        }
    }
    
    public override init() {
        super.init()

        NotificationCenter.default.addObserver(forName: .UIApplicationWillEnterForeground, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.appWillEnterForeground()
        }

        NotificationCenter.default.addObserver(forName: .UIApplicationDidEnterBackground, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.appDidEnterBackground()
        }

        NotificationCenter.default.addObserver(forName: Notification.Name("reachabilityChanged"), object: nil, queue: OperationQueue.main) { [weak self] (notification) in
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
        
    open func addOrCancelDataTask(dataTask :URLSessionTask) {
        cleanDataTasksArray()
        guard dataTasks.filter ({ $0.value?.originalRequest?.url == dataTask.originalRequest?.url }).count == 0 else {
            dataTask.cancel()
            return
        }
        dataTasks.append(WeakRefURLSessionTask(value: dataTask))
        dataTask.resume()
    }

    open func cleanDataTasksArray() {
        dataTasks = dataTasks.filter { $0.value != nil && ($0.value!.state == .suspended || $0.value!.state == .running) }
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
