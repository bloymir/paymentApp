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
        let urlBase = Constants.kUrlBase
        let paymentMethod = "\(Constants.kPaymentMethods)s"
        let keyPublic = "?\(Constants.kKeyString)"
        
        guard let url = URL(string: "\(urlBase + paymentMethod + keyPublic)") else { return }

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
