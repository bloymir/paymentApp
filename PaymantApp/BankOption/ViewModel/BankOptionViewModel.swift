
import Foundation

class BankOptionViewModel {
    func getBankOptionDataArray(completion: @escaping ([BankOptionResponse]?) -> Void) {
        BankOptionService.getBankOption { banks in
            completion(banks)
        }
    }
}

    
 
