//
//  PaymentMethodViewModel.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//
import Foundation

class PaymentMethodViewModel {
    var dataArrayNoFilteres: [PaymentMethodResponse] = []
    var refreshData = { () -> () in }
    
    var dataArray: [PaymentMethodResponse] = [] {
        didSet {
            refreshData()
        }
    }
    
    
    func retryDataList() {
        
        guard let url = URL(string: "https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else { return }
            
            do {
                let decoder = JSONDecoder()
                self.dataArrayNoFilteres = try decoder.decode([PaymentMethodResponse].self, from: json)
                self.dataArray = self.dataArrayNoFilteres.filter({ paymentMethods -> Bool in
                    paymentMethods.payment_type_id == "credit_card"
                }).sorted(by: { (one, two) -> Bool in one.name ?? "" < two.name ?? "" })
                
            } catch let error {
                print("Ha ocurrido un error \(error.localizedDescription)")
            }
        }.resume()
    }
    
     
}
