//
//  BankOptionViewModel.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

import Foundation

class BankOptionViewModel {
    func getBankOptionDataArray(completion: @escaping ([BankOptionResponse]?) -> Void) {
        BankOptionService.getBankOption { banks in
            completion(banks)
        }
    }
}

    
 
