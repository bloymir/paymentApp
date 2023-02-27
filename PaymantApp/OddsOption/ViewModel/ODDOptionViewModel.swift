//
//  ODDOptionViewModel.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

import Foundation

class OddOptionViewModel {
    func retryDataList(completion: @escaping ([PayerCosts]?) -> Void) {
        OddOptionService.getResponse { oddElements in
            completion(oddElements)

        }
    }
    
   
}
    

