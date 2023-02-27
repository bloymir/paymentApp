import Foundation

class PaymentMethodViewModel {
    
    func getPaymentDataArray(completion: @escaping ([PaymentMethodResponse]?) -> Void) {
        PaymentMethodService.getPaymentMethods { paymentMethod in
            completion(paymentMethod)
        }
    }
    
}
