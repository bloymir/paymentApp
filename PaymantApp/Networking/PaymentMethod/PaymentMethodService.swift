//
//  PaymentMethodService.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

import Foundation
import Alamofire

final class PaymentMethodService {

    static var paymentMethods: [PaymentMethodResponse]?
    static let url = "https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88"

    static func getJsonResponse(data: Data) -> [PaymentMethodResponse]? {
        do { paymentMethods = try JSONDecoder().decode([PaymentMethodResponse].self, from: data) }
        catch let error { print("Payment Methods Error Services \(error.localizedDescription)") }
        return paymentMethods?.filter({ paymentMethods -> Bool in
            paymentMethods.payment_type_id == "credit_card"
        }).sorted(by: { (lhs, rhs) -> Bool in lhs.name ?? "" < rhs.name ?? "" })
    }

    static func getPaymentMethods(completion: @escaping ([PaymentMethodResponse]?) -> Void) {
        AF.request(url, method: .get, encoding: URLEncoding.default).response {
            response in
            if let data = response.data {
                completion(getJsonResponse(data: data))
            }
        }
    }
}




