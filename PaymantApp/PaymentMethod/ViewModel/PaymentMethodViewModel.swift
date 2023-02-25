//
//  PaymentMethodViewModel.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//
import Foundation

class PaymentMethodViewModel {
    func getPaymentMethods(completion: @escaping ([PaymentMethodResponse]?) -> Void) {
        PaymentMethodService.getPaymentMethods{ paymentMethod in
            completion(paymentMethod)
        }
    }
}
