//
//  PaymentMethodService.swift
//  PaymantApp
//
//  Created by nelson tapia on 27-02-23.
//

import Foundation
import Alamofire

class PaymentMethodService {
    static var paymentMethods: [PaymentMethodResponse]?
    static let url = "https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88"
    
    static func getJson(data: Data) -> [PaymentMethodResponse]? {
        do { paymentMethods = try JSONDecoder().decode([PaymentMethodResponse].self, from: data) }
        catch let error { print("PaymenthMethodService error: \(error.localizedDescription)") }
        let response = paymentMethods?.filter({ paymentMethod -> Bool in
            paymentMethod.paymentTypeId == "credit_card"
        }).sorted(by: { (first, second) -> Bool in first.name ?? "" < second.name ?? "" })
        return response
    }
    
    static func getPaymentMethods(completion: @escaping ([PaymentMethodResponse]?) -> Void) {
        AF.request(url, method: .get, encoding: URLEncoding.default).response {
            response in
            if let data = response.data {
                completion(getJson(data: data))
            }
        }
    }
}
