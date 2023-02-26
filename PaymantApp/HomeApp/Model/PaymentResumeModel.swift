//
//  PaymentResumeModel.swift
//  PaymantApp
//
//  Created by nelson tapia on 26-02-23.
//



class PaymentResumeModel {
    static let shared = PaymentResumeModel()
    
    var paymentCompleted = false
    var amountToPage: Int?
    var paymentMethodId: String?
    var paymentMethodName: String?
    var bankOptionId: String?
    var bankOptionName: String?
    var oddsOption: String?
    var oddsAmount: String?
    var totalSelected: String?
    
    private init() {}
}
