//
//  Constants+Internal.swift
//  UrbanPiper
//
//  Created by Vid on 06/03/19.
//

import UIKit

public extension PaymentOption {
    
    public var displayName: String {
        switch self {
        case .cash:
            return "Cash on delivery"
        case .prepaid:
            return "Wallet"
        case .paymentGateway:
            return "Pay online"
        case .paytm:
            return "PAYTM"
        case .simpl:
            return "Simpl"
        case .paypal:
            return "Paypal"
        case .select:
            return "SELECT OPTION"
        }
    }
    
}

public extension DeliveryOption {
    public var deliveryOptionOffsetTimeSecs: TimeInterval {
        switch self {
        case .delivery:
            return TimeInterval((OrderingStoreDataModel.shared.orderingStore?.deliveryMinOffsetTime ?? Biz.shared!.deliveryMinOffsetTime) / 1000)
        case .pickUp:
            return TimeInterval((OrderingStoreDataModel.shared.orderingStore?.pickupMinOffsetTime ?? Biz.shared!.pickupMinOffsetTime) / 1000)
        }
    }
}
