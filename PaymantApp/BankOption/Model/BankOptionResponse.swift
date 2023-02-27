//
//  BankOptionResponse.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

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
