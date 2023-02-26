//
//  BankOptionViewModel.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

import Foundation

class BankOptionViewModel {
    
    var refreshData = { () -> () in }
    var dataArray: [BankOptionResponse] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retryDataList() {
        
        let urlBase = Constants.kUrlBase
        let bankOption = Constants.kBankOption
        let keyPublic = "?\(Constants.kKeyString)"
        let paymentMethod = "&\(Constants.kPaymentMethods)_id="
        let paymentMethodId = PaymentResumeModel.shared.paymentMethodId!
        
        guard let url = URL(string: "\(urlBase + bankOption + keyPublic + paymentMethod + paymentMethodId)") else { return }

        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else { return }
            
            do {
                let decoder = JSONDecoder()
                self.dataArray = try decoder.decode([BankOptionResponse].self, from: json)
                
            } catch let error {
                print("Ha ocurrido un error \(error.localizedDescription)")
            }
        }.resume()
    }
}
