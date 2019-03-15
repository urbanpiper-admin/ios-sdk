//
//  AddressDataModel.swift
//  UrbanPiper
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
    func configureAddressCell(_ address: Address?)
}


public struct DefaultAddressUserDefaultKeys {
    static let defaultDeliveryAddressKey: String = "DefaultDeliveryAddress"
}

public class AddressDataModel: UrbanPiperDataModel {

    
    @objc public static private(set) var shared: AddressDataModel = AddressDataModel()

    private typealias WeakRefDataModelDelegate = WeakRef<AddressDataModelDelegate>

    private var observers = [WeakRefDataModelDelegate]()

    public var userAddressesResponse: UserAddressesResponse? {
        didSet {
            let addresses: [Address]? = userAddressesResponse?.addresses
            var serverDefaultDeliveryAddress: Address?
            if let defaultAddress: Address = defaultDeliveryAddress {
                serverDefaultDeliveryAddress = addresses?.filter ({ $0.id == defaultAddress.id }).last
                if serverDefaultDeliveryAddress == nil {
                    defaultDeliveryAddress = nil
                }
            }
            
            if let address: Address = addresses?.first, defaultDeliveryAddress == nil {
                defaultDeliveryAddress = address
                serverDefaultDeliveryAddress = address
            }
            
            if let val = serverDefaultDeliveryAddress, let index = userAddressesResponse?.addresses?.index(of: val), index > 2 {
                userAddressesResponse?.addresses?.remove(at: index)
                userAddressesResponse?.addresses?.insert(val, at: 0)
            }
            
            addressListArray = userAddressesResponse?.addresses
            deliverableAddressListArray = userAddressesResponse?.addresses.filter { $0.deliverable != nil && $0.deliverable! }
            unDeliverableAddressListArray = userAddressesResponse?.addresses.filter { $0.deliverable != nil && !$0.deliverable! }
            
            tableView?.reloadData()
            collectionView?.reloadData()
        }
    }
    
    public var addressListArray: [Address]?
    public var deliverableAddressListArray: [Address]?
    public var unDeliverableAddressListArray: [Address]?

    public var defaultDeliveryAddress: Address? {
        get {
            if let defaultAddressData: Data = UserDefaults.standard.object(forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey) as? Data {
                Address.registerClass()
                guard let address: Address = NSKeyedUnarchiver.unarchiveObject(with: defaultAddressData) as? Address else { return nil }
                return address
            } else if let defaultAddressData: Data = UserDefaults.standard.object(forKey: "DefaultAddressDefaultsKey") as? Data {
                UserDefaults.standard.removeObject(forKey: "DefaultAddressDefaultsKey")
                Address.registerClass()
                guard let address: Address = NSKeyedUnarchiver.unarchiveObject(with: defaultAddressData) as? Address else { return nil }
                UserDefaults.standard.set(defaultAddressData, forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey)
                return address
            } else {
                guard let address = self.userAddressesResponse?.addresses.first else { return nil }
                let defaultAddressData = NSKeyedArchiver.archivedData(withRootObject: address)

                UserDefaults.standard.set(defaultAddressData, forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey)
                return address
            }
        }
        set {
            if let val = newValue {
                let defaultAddressData = NSKeyedArchiver.archivedData(withRootObject: val)
                if let index = userAddressesResponse?.addresses?.index(of: val), index > 2 {
                    userAddressesResponse?.addresses?.remove(at: index)
                    userAddressesResponse?.addresses?.insert(val, at: 0)
                }
                UserDefaults.standard.set(defaultAddressData, forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey)
                _ = observers.map { $0.value?.refreshDeliveryAddressUI(isRefreshing: false) }
            } else {
                UserDefaults.standard.removeObject(forKey: DefaultAddressUserDefaultKeys.defaultDeliveryAddressKey)
                _ = observers.map { $0.value?.refreshDeliveryAddressUI(isRefreshing: false) }
            }
        }
    }
    
    private override init() {
        super.init()
        
        refreshData()
    }
    
    public func addObserver(delegate: AddressDataModelDelegate) {
        let weakRefDataModelDelegate: WeakRefDataModelDelegate = WeakRefDataModelDelegate(value: delegate)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier!, for: indexPath)
        
        if let addressCell: AddressCellDelegate = cell as? AddressCellDelegate {
            addressCell.configureAddressCell(addressListArray?[indexPath.row])
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier!, for: indexPath)
        
        if let addressCell: AddressCellDelegate = cell as? AddressCellDelegate {
            addressCell.configureAddressCell(addressListArray?[indexPath.row])
        } else {
            assert(false, "Cell does not conform to AddressCellDelegate protocol")
        }
        
        return cell
    }
    
}

//  MARK: API Calls

extension AddressDataModel {
    
    fileprivate func fetchAddressList() {
        guard UserManager.shared.currentUser != nil else { return }
        userAddressesResponse = nil
        addressListArray = nil
        deliverableAddressListArray = nil
        unDeliverableAddressListArray = nil
        _ = observers.map { $0.value?.refreshDeliveryAddressUI(isRefreshing: true) }
        let dataTask: URLSessionDataTask = APIManager.shared.getDeliverableAddresses(storeId: OrderingStoreDataModel.shared.orderingStore?.bizLocationId,
                                                                                           completion: { [weak self] (data) in
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
        addDataTask(dataTask: dataTask)
    }
    
    public func addAddress(address: Address) {
        _ = observers.map { $0.value?.refreshAddAddressUI(isRefreshing: true) }
        let dataTask: URLSessionDataTask = APIManager.shared.addAddress(address: address, completion: { [weak self] (data) in
            defer {
                _ = self?.observers.map { $0.value?.refreshAddAddressUI(isRefreshing: false) }
            }
            guard let response = data, let addressId = response.addressId else { return }
            address.id = addressId
            address.deliverable = true
            self?.defaultDeliveryAddress = address
            
            var addressesResponse = self?.userAddressesResponse

            addressesResponse?.addresses = self?.addressListArray?.filter { $0.id != address.id }
            addressesResponse?.addresses?.insert(address, at: 0)
            
            self?.userAddressesResponse = addressesResponse
            }, failure: { [weak self] (upError) in
                defer {
                    _ = self?.observers.map { $0.value?.handleAddress(error: upError) }
                }
        })
        addDataTask(dataTask: dataTask)
    }
    
    public func updateAddress(address: Address) {
        _ = observers.map { $0.value?.refreshUpdateAddressUI(isRefreshing: true) }
        let dataTask: URLSessionDataTask = APIManager.shared.updateAddress(address: address, completion: { [weak self] (data) in
            defer {
                _ = self?.observers.map { $0.value?.refreshUpdateAddressUI(isRefreshing: false) }
            }
            
            guard let response = data, let addressId = response.addressId else { return }
            address.id = addressId
            
            self?.defaultDeliveryAddress = address
            
            var addressesResponse = self?.userAddressesResponse
            address.deliverable = self?.addressListArray?.filter { $0.id == address.id }.last?.deliverable ?? false

            addressesResponse?.addresses = self?.addressListArray?.filter { $0.id != address.id }
            addressesResponse?.addresses.insert(address, at: 0)

            self?.userAddressesResponse = addressesResponse
            
            
            }, failure: { [weak self] (upError) in
                defer {
                    _ = self?.observers.map { $0.value?.handleAddress(error: upError) }
                }
        })
        addDataTask(dataTask: dataTask)
    }
    
    public func deleteAddress(address: Address) {
        _ = observers.map { $0.value?.refreshDeleteAddressUI(isRefreshing: true) }
        let dataTask: URLSessionDataTask = APIManager.shared.deleteAddress(addressId: address.id, completion: { [weak self] _ in
            var addressesResponse = self?.userAddressesResponse
            
            addressesResponse?.addresses = self?.addressListArray?.filter { $0.id != address.id }
            self?.userAddressesResponse = addressesResponse
            
            self?.defaultDeliveryAddress = self?.addressListArray?.first
            _ = self?.observers.map { $0.value?.refreshDeleteAddressUI(isRefreshing: false) }
            }, failure: { [weak self] (upError) in
                defer {
                    _ = self?.observers.map { $0.value?.handleAddress(error: upError) }
                }
        })
        addDataTask(dataTask: dataTask)
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

