
import Foundation
import Alamofire

class PaymentMethodService {
    static var paymentMethods: [PaymentMethodResponse]?
    
    static let urlBase = Constants.kUrlBase
    static let paymentMethod = "\(Constants.kPaymentMethods)s"
    static let keyPublic = "?\(Constants.kKeyString)"
    
    static func getJson(data: Data) -> [PaymentMethodResponse]? {
        do { paymentMethods = try JSONDecoder().decode([PaymentMethodResponse].self, from: data) }
        catch let error { print("PaymenthMethodService error: \(error.localizedDescription)") }
        return paymentMethods
    }
    
    static func getPaymentMethods(completion: @escaping ([PaymentMethodResponse]?) -> Void) {
        let url = urlBase + paymentMethod + keyPublic
        
        AF.request(url, method: .get, encoding: URLEncoding.default).response {
            response in
            if let data = response.data {
                completion(getJson(data: data))
            }
        }
    }
}
