//
//  APIManager+Payment.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum PaymentsAPI {
    case preProcessOrder(storeId: Int, applyWalletCredit: Bool, deliveryOption: DeliveryOption, cartItems: [CartItem], orderTotal: Double)
    case initiateOnlinePayment(paymentOption: PaymentOption, totalAmount: Double, storeId: Int)
    case initiateWalletReload(paymentOption: PaymentOption, totalAmount: Double)

    case placeOrder(address: Address?, cartItems: [CartItem], deliveryDate: Date, timeSlot: TimeSlot?, deliveryOption: DeliveryOption,
                    instructions: String, phone: String, storeId: Int, paymentOption: PaymentOption, taxRate: Float, couponCode: String?,
                    deliveryCharge: Double, discountApplied: Double, itemTaxes: Double, packagingCharge: Double, orderSubTotal: Double,
                    orderTotal: Double, applyWalletCredit: Bool, walletCreditApplied: Double, payableAmount: Double, paymentInitResponse: PaymentInitResponse?)
    case verifyPayment(pid: String, orderId: String, transactionId: String)
}

extension PaymentsAPI: UPAPI {
    var path: String {
        switch self {
        case .preProcessOrder:
            return "api/v1/order/"
        case let .initiateOnlinePayment(_, _, storeId):
            return "payments/init/\(APIManager.shared.bizId)/\(storeId)/"
        case .initiateWalletReload:
            return "payments/init/\(APIManager.shared.bizId)/"
        case .placeOrder:
            return "api/v1/order/"
        case let .verifyPayment(_, _, transactionId):
            return "payments/callback/\(transactionId)/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case .preProcessOrder:
            return ["format": "json",
                    "pre_proc": "1",
                    "biz_id": APIManager.shared.bizId]
        case let .initiateOnlinePayment(paymentOption, totalAmount, _):
            var params = ["amount": "\(Int(totalAmount * 100))",
                          "purpose": OnlinePaymentPurpose.ordering.rawValue,
                          "channel": APIManager.channel] as [String: String]

            params[paymentOption.rawValue] = "1"

            switch paymentOption {
            case .paytm, .paymentGateway:
                params["redirect_url"] = "https://urbanpiper.com/pg-redirect"
            default: break
            }

            return params

        case let .initiateWalletReload(paymentOption, totalAmount):
            var params = ["amount": "\(Int(totalAmount * 100))",
                          "purpose": OnlinePaymentPurpose.reload.rawValue,
                          "channel": APIManager.channel] as [String: String]

            params[paymentOption.rawValue] = "1"

            switch paymentOption {
            case .paytm, .paymentGateway:
                params["redirect_url"] = "https://urbanpiper.com/pg-redirect"
            default: break
            }

            return params
        case .placeOrder:
            return ["format": "json",
                    "biz_id": APIManager.shared.bizId]
        case let .verifyPayment(pid, orderId, _):
            return ["gateway_txn_id": pid,
                    "pid": orderId]
        }
    }

    var headers: [String: String]? {
        switch self {
        case .preProcessOrder:
            return nil
        case .initiateOnlinePayment:
            return nil
        case .initiateWalletReload:
            return nil
        case .placeOrder:
            return nil
        case .verifyPayment:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .preProcessOrder:
            return .POST
        case .initiateOnlinePayment:
            return .GET
        case .initiateWalletReload:
            return .GET
        case .placeOrder:
            return .POST
        case .verifyPayment:
            return .GET
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case let .preProcessOrder(storeId, applyWalletCredit, deliveryOption, cartItems, orderTotal):
            return ["biz_location_id": storeId,
                    "apply_wallet_credit": applyWalletCredit,
                    "order_type": deliveryOption.rawValue,
                    "channel": APIManager.channel,
                    "items": cartItems.map { $0.toDictionary() },
                    "order_total": orderTotal] as [String: AnyObject]
        case .initiateOnlinePayment:
            return nil
        case .initiateWalletReload:
            return nil
        case let .placeOrder(address, cartItems, deliveryDate, timeSlot, deliveryOption, instructions, phone, storeId, paymentOption, taxRate, couponCode, deliveryCharge, discountApplied, itemTaxes, packagingCharge, orderSubTotal, orderTotal, applyWalletCredit, walletCreditApplied, payableAmount, paymentInitResponse):

            let itemWithInstructionsArray = cartItems.filter { $0.notes != nil && $0.notes!.count > 0 }
            var instructionsText: String

            if itemWithInstructionsArray.count > 0 {
                let itemsInstructionsStringArray = itemWithInstructionsArray.map { "\($0.itemTitle) : \($0.notes!)" }
                instructionsText = "\(itemsInstructionsStringArray.joined(separator: ",\n"))"
                if instructions.count > 0 {
                    instructionsText = "\(instructionsText)\n general instructions: \(instructions))"
                }
            } else {
                instructionsText = instructions
            }

            var params = ["channel": APIManager.channel,
                          "order_type": deliveryOption.rawValue,
                          "instructions": instructionsText,
                          "items": cartItems.map { $0.toDictionary() },
                          "payment_option": paymentOption.rawValue,
                          "phone": phone,
                          "biz_location_id": storeId,
                          "delivery_datetime": Int(deliveryDate.timeIntervalSince1970 * 1000),
                          "order_subtotal": orderSubTotal,
                          "tax_rate": taxRate,
                          "packaging_charge": packagingCharge,
                          "item_taxes": itemTaxes,
                          "discount_applied": discountApplied,
                          "delivery_charge": deliveryOption == DeliveryOption.pickUp ? Double.zero : deliveryCharge,
                          "order_total": orderTotal] as [String: AnyObject]

            if applyWalletCredit {
                params["wallet_credit_applicable"] = true as AnyObject
                params["wallet_credit_applied"] = walletCreditApplied as AnyObject
                params["payable_amount"] = payableAmount as AnyObject
            }

            if let code = couponCode {
                params["coupon"] = code as AnyObject
            }

            if let addressObject = address, deliveryOption != DeliveryOption.pickUp {
                params["address_id"] = addressObject.id as AnyObject
                params["address_lat"] = addressObject.lat as AnyObject
                params["address_lng"] = addressObject.lng as AnyObject
            }

            if let timeSlotObject = timeSlot {
                params["time_slot_end"] = timeSlotObject.endTime as AnyObject
                params["time_slot_start"] = timeSlotObject.startTime as AnyObject
            }

            if let trxId = paymentInitResponse?.transactionid {
                params["payment_server_trx_id"] = trxId as AnyObject
                params["state"] = "awaiting_payment" as AnyObject
            }

            return params
        case .verifyPayment:
            return nil
        }
    }
}
