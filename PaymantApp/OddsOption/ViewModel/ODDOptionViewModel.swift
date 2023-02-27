

import Foundation

class OddOptionViewModel {
    func retryDataList(completion: @escaping ([PayerCosts]?) -> Void) {
        OddOptionService.getResponse { oddElements in
            completion(oddElements)

        }
    }
    
   
}
    

