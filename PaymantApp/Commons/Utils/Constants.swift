struct Constants {
    static let kUrlBase = "https://api.mercadopago.com/v1/"
    static let kPublicKey = "444a9ef5-8a6b-429f-abdf-587639155d88"
    static let kKeyString = "public_key=\(kPublicKey)"
    static let kPaymentMethods = "payment_method"
    static let kBankOption = "payment_methods/card_issuers"
    static let kOddOption = "payment_methods/installments"
}
