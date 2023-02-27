struct PaymentMethodResponse: Decodable {
    let id: String?
    let name: String?
    let thumbnail: String?
    let paymentTypeId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case thumbnail
        case paymentTypeId = "payment_type_id"
    }
}
