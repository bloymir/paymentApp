
struct BankOptionResponse: Decodable {
    let id: String?
    let name: String?
    let status: String?
    let secureThumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case secureThumbnail = "secure_thumbnail"
    }
}
