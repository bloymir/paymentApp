import Foundation
import Alamofire

class OddOptionService {
    static var oddOptionResponse: [OddOptionResponse]?
    
    static let urlBase = Constants.kUrlBase
    static let oddOption = Constants.kOddOption
    static let keyPublic = "?\(Constants.kKeyString)"
    static let mount = "&amount="
    static let paymentMethod = "&\(Constants.kPaymentMethods)_id="
    static let paymentMethodId = PaymentResumeModel.shared.paymentMethodId!
    
    static func decodeJson(data: Data) -> [PayerCosts]? {
        do { oddOptionResponse = try JSONDecoder().decode([OddOptionResponse].self, from: data) }
        catch let error { print("Error \(error.localizedDescription)") }
        return oddOptionResponse?[0].payer_costs
    }
    
    static func getResponse(completion: @escaping ([PayerCosts]?) -> Void) {
        let url = urlBase + oddOption + keyPublic + mount + String(PaymentResumeModel.shared.amountToPage) + paymentMethod + paymentMethodId
        
        AF.request(url, method: .get, encoding: URLEncoding.default).response {
            response in
            if let data = response.data {
                completion(decodeJson(data: data))
            }
        }
    }
}
