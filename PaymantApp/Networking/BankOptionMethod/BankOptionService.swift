
import Foundation
import Alamofire

class BankOptionService {
    static var bankOptions: [BankOptionResponse]?
    
    static let urlBase = Constants.kUrlBase
    static let kbankOption = Constants.kBankOption
    static let keyPublic = "?\(Constants.kKeyString)"
    static let paymentMethod = "&\(Constants.kPaymentMethods)_id="
  
    
    static func getJson(data: Data) -> [BankOptionResponse]? {
        do { bankOptions = try JSONDecoder().decode([BankOptionResponse].self, from: data) }
        catch let error { print("CardIssuerService error: \(error.localizedDescription)") }
        let value = bankOptions?.filter({ cardIssuer -> Bool in
            cardIssuer.status == "active"
        }).sorted(by: { (first, second) -> Bool in first.name ?? "" < second.name ?? "" })
        return value
    }
    
    static func getBankOption(completion: @escaping ([BankOptionResponse]?) -> Void) {
        
        var url = urlBase + kbankOption + keyPublic + paymentMethod + PaymentResumeModel.shared.paymentMethodId!
      
        AF.request(url, method: .get, encoding: URLEncoding.default).response {
            response in
            if let data = response.data {
                completion(getJson(data: data))
            }
        }
    }
    
}
