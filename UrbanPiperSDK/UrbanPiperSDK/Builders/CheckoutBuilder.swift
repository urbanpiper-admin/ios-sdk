//
//  CheckoutBuilder.swift
//  UrbanPiperSDK
//
//  Created by Vid on 21/02/19.
//

import UIKit

public class CheckoutBuilder: NSObject {
    
    @discardableResult public func validateCart(bizLocationId: Int, applyWalletCredit: Bool,
                                                deliveryOption: String, cartItems: [CartItem], orderTotal: Decimal,
                                                completion: @escaping ((PreProcessOrderResponse?) -> Void), failure: APIFailure?) -> URLSessionDataTask {
        return APIManager.shared.preProcessOrder(bizLocationId: bizLocationId, applyWalletCredit: applyWalletCredit,
                                                 deliveryOption: deliveryOption, cartItems: cartItems, orderTotal: orderTotal,
                                                 completion: completion, failure: failure)
    }
    
    @discardableResult @objc public func apply(coupon: String, storeLocationId: Int, deliveryOption: String,
                                               items: [[String: Any]], applyWalletCredit: Bool,
                                               completion: ((Order?) -> Void)?,
                                               failure: APIFailure?) -> URLSessionDataTask {
        return APIManager.shared.apply(coupon: coupon, storeLocationId: storeLocationId, deliveryOption: deliveryOption,
                                       items: items, applyWalletCredit: applyWalletCredit,
                                       completion: completion, failure: failure)
    }

    @discardableResult public func initPayment(paymentOption: PaymentOption,
                                        purpose: OnlinePaymentPurpose,
                                        totalAmount: Decimal,
                                        bizLocationId: Int?,
                                        completion: ((OnlinePaymentInitResponse?) -> Void)?,
                                        failure: APIFailure?) -> URLSessionDataTask? {
        return APIManager.shared.initiateOnlinePayment(paymentOption: paymentOption,
                                                       purpose: purpose,
                                                       totalAmount: totalAmount,
                                                       bizLocationId: bizLocationId,
                                                       completion: completion,
                                                       failure: failure)
    }
    
    @discardableResult public func placeOrder(address: Address?,
                             cartItems: [CartItem],
                             deliveryDate: Date,
                             timeSlot: TimeSlot?,
                             deliveryOption: DeliveryOption,
                             instructions: String,
                             phone: String,
                             bizLocationId: Int,
                             paymentOption: String,
                             taxRate: Float,
                             couponCode: String?,
                             deliveryCharge: Decimal,
                             discountApplied: Decimal,
                             itemTaxes: Decimal,
                             packagingCharge: Decimal,
                             orderSubTotal: Decimal,
                             orderTotal: Decimal,
                             applyWalletCredit: Bool,
                             walletCreditApplied: Decimal,
                             payableAmount: Decimal,
                             onlinePaymentInitResponse: OnlinePaymentInitResponse?,
                             completion: ((OrderResponse?) -> Void)?,
                             failure: APIFailure?) -> URLSessionDataTask {
        return APIManager.shared.placeOrder(address: address, cartItems: cartItems, deliveryDate: deliveryDate, timeSlot: timeSlot, deliveryOption: deliveryOption, instructions: instructions, phone: phone, bizLocationId: bizLocationId, paymentOption: paymentOption, taxRate: taxRate, couponCode: couponCode, deliveryCharge: deliveryCharge, discountApplied: discountApplied, itemTaxes: itemTaxes, packagingCharge: packagingCharge, orderSubTotal: orderSubTotal, orderTotal: orderTotal, applyWalletCredit: applyWalletCredit, walletCreditApplied: walletCreditApplied, payableAmount: payableAmount, onlinePaymentInitResponse: onlinePaymentInitResponse, completion: completion, failure: failure)
    }
    
    @discardableResult public func verifyPayment(pid: String,
                                      orderId: String,
                                      transactionId: String,
                                      completion: ((OrderVerifyTxnResponse?) -> Void)?,
                                      failure: APIFailure?) -> URLSessionDataTask {
        return APIManager.shared.verifyPayment(pid: pid, orderId: orderId, transactionId: transactionId, completion: completion, failure: failure)
    }
}
