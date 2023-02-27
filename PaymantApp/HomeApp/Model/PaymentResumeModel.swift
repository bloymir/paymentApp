
class PaymentResumeModel {
    static let shared = PaymentResumeModel()
    
    var paymentCompleted = false
    var amountToPage: Int = 0
    var paymentMethodId: String?
    var paymentMethodName: String?
    var bankOptionId: String?
    var bankOptionName: String?
    var oddsOption: String?
    var totalSelected: String?
    
    private init() {}
    
    func cleanShered() {
        PaymentResumeModel.shared.paymentCompleted = false
        PaymentResumeModel.shared.amountToPage = 0
        PaymentResumeModel.shared.paymentMethodId = ""
        PaymentResumeModel.shared.paymentMethodName = ""
        PaymentResumeModel.shared.bankOptionId = ""
        PaymentResumeModel.shared.bankOptionName = ""
        PaymentResumeModel.shared.oddsOption = ""
        PaymentResumeModel.shared.totalSelected = ""
    }
}
