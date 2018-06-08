//
//  AddressDataModel.swift
//  UrbanPiperSDK
//
//  Created by Vidhyadharan Mohanram on 28/05/18.
//  Copyright © 2018 UrbanPiper. All rights reserved.
//

import UIKit

@objc public protocol AddressDataModelDelegate {

    func refreshDeliveryAddressUI(isRefreshing: Bool)
    func refreshAddAddressUI(isRefreshing: Bool)
    func refreshUpdateAddressUI(isRefreshing: Bool)
    func refreshDeleteAddressUI(isRefreshing: Bool)

    func handleAddress(error: UPError?)
    
}

@objc public protocol AddressCellDelegate {
    func configureCell(_ address: Address?)
}


public struct DefaultAddressUserDefaultKeys {
    static let defaultDeliveryAddressKey = "DefaultDeliveryAddress"
}

public class AddressDataModel: UrbanPiperDataModel {

    
    @objc public static private(set) var shared = AddressDataModel()

    private typealias WeakRefDataModelDelegate = WeakRef<AddressDataModelDelegate>

    private var observers = [WeakRefDataModelDelegate]()

    public var userAddressesResponse: UserAddressesResponse? {
        didSet {
            if let defaultAddress = defaultDeliveryAddress {
                if userAddressesResponse?.addresses.filter ({ $0.id == defaultAddress.id }).last == nil {
                    defaultDeliveryAddress = nil
                }
            }
            if let address = userAddressesResponse?.addresses.first, defaultDeliveryAddress == nil {
                defaultDeliveryAddress = address
            }
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }
    
    public var addressListArray: [Address]? {
        return userAddressesResponse?.addresses
    }

    public var defaultDeliveryAddress: Address? {
        get {
            if let defaultAddressData = UserDefaults.standard.object(forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey) as? Data {
                Address.registerClassName()
                guard let address = NSKeyedUnarchiver.unarchiveObject(with: defaultAddressData) as? Address else { return nil }
                return address
            } else if let defaultAddressData = UserDefaults.standard.object(forKey: "DefaultAddressDefaultsKey") as? Data {
                UserDefaults.standard.removeObject(forKey: "DefaultAddressDefaultsKey")
                Address.registerClassName()
                Address.registerClassNameWhiteLabel()
                guard let address = NSKeyedUnarchiver.unarchiveObject(with: defaultAddressData) as? Address else { return nil }
                UserDefaults.standard.set(defaultAddressData, forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey)
                return address
            } else {
                guard let address = self.userAddressesResponse?.addresses.first else { return nil }
                Address.registerClassName()
                let defaultAddressData = NSKeyedArchiver.archivedData(withRootObject: address)

                UserDefaults.standard.set(defaultAddressData, forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey)
                return address
            }
        }
        set {
            if let val = newValue {
                Address.registerClassName()
                let defaultAddressData = NSKeyedArchiver.archivedData(withRootObject: val)

                UserDefaults.standard.set(defaultAddressData, forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey)
            } else {
                UserDefaults.standard.removeObject(forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey)
            }
        }
    }
    
    private override init() {
        super.init()
        
        refreshData()
    }
    
    public func addObserver(delegate: AddressDataModelDelegate) {
        let weakRefDataModelDelegate = WeakRefDataModelDelegate(value: delegate)
        observers.append(weakRefDataModelDelegate)
    }
    
    
    public func removeObserver(delegate: AddressDataModelDelegate) {
        guard let index = (observers.index { $0.value === delegate }) else { return }
        observers.remove(at: index)
    }

    
    public func refreshData(_ isForcedRefresh: Bool = false) {
        fetchAddressList()
    }
    
}

//  MARK: UITableView DataSource
extension AddressDataModel {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressListArray?.count ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)
        
        if let addressCell = cell as? AddressCellDelegate {
            addressCell.configureCell(addressListArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to AddressCellDelegate protocol")
        }
        
        return cell
    }
}

//  MARK: UICollectionView DataSource

extension AddressDataModel {
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addressListArray?.count ?? 0
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier!, for: indexPath)
        
        if let addressCell = cell as? AddressCellDelegate {
            
            addressCell.configureCell(addressListArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to AddressCellDelegate protocol")
        }
        
        return cell
    }
    
}

//  MARK: API Calls

extension AddressDataModel {
    
    fileprivate func fetchAddressList() {
        _ = observers.map { $0.value?.refreshDeliveryAddressUI(isRefreshing: true) }
        let dataTask = APIManager.shared.userSavedAddresses(completion: { [weak self] (data) in
            defer {
                _ = self?.observers.map { $0.value?.refreshDeliveryAddressUI(isRefreshing: false) }
            }
            guard let response = data else { return }
            self?.userAddressesResponse = response
            }, failure: { [weak self] (upError) in
                defer {
                    _ = self?.observers.map { $0.value?.handleAddress(error: upError) }
                }
        })
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func addAddress(address: Address) {
        _ = observers.map { $0.value?.refreshAddAddressUI(isRefreshing: true) }
        let dataTask = APIManager.shared.addAddress(address: address, completion: { [weak self] (data) in
            defer {
                _ = self?.observers.map { $0.value?.refreshAddAddressUI(isRefreshing: false) }
            }
            guard let response = data, let addressId = response.addressId else { return }
            address.id = addressId
            self?.defaultDeliveryAddress = address
            self?.userAddressesResponse?.addresses = self?.addressListArray?.filter { $0.id != address.id }
            self?.userAddressesResponse?.addresses.insert(address, at: 0)
            
            }, failure: { [weak self] (upError) in
                defer {
                    _ = self?.observers.map { $0.value?.handleAddress(error: upError) }
                }
        })
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func updateAddress(address: Address) {
        _ = observers.map { $0.value?.refreshUpdateAddressUI(isRefreshing: true) }
        let dataTask = APIManager.shared.updateAddress(address: address, completion: { [weak self] (data) in
            defer {
                _ = self?.observers.map { $0.value?.refreshUpdateAddressUI(isRefreshing: false) }
            }
            
            guard let response = data, let addressId = response.addressId else { return }
            address.id = addressId
            
            self?.defaultDeliveryAddress = address
            self?.userAddressesResponse?.addresses = self?.addressListArray?.filter { $0.id != address.id }
            self?.userAddressesResponse?.addresses.insert(address, at: 0)
            
            }, failure: { [weak self] (upError) in
                defer {
                    _ = self?.observers.map { $0.value?.handleAddress(error: upError) }
                }
        })
        addOrCancelDataTask(dataTask: dataTask)
    }
    
    public func deleteAddress(address: Address) {
        _ = observers.map { $0.value?.refreshDeleteAddressUI(isRefreshing: true) }
        let dataTask = APIManager.shared.deleteAddress(address: address, completion: { [weak self] in
            self?.userAddressesResponse?.addresses = self?.addressListArray?.filter { $0.id != address.id }
            self?.defaultDeliveryAddress = self?.addressListArray?.first
            _ = self?.observers.map { $0.value?.refreshDeleteAddressUI(isRefreshing: false) }
            }, failure: { [weak self] (upError) in
                defer {
                    _ = self?.observers.map { $0.value?.handleAddress(error: upError) }
                }
        })
        addOrCancelDataTask(dataTask: dataTask)
    }
}

//  App State Management

extension AddressDataModel {
    
    open override func appWillEnterForeground() {
        guard userAddressesResponse == nil else { return }
        refreshData()
    }
    
    @objc open override func appDidEnterBackground() {
        
    }
    
}

//  Reachability

extension AddressDataModel {
    
    open override func networkIsAvailable() {
        guard userAddressesResponse == nil else { return }
        refreshData()
    }
    
}
