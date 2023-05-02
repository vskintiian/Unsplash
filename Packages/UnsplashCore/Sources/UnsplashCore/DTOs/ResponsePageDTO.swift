//
//  ResponsePageDTO.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import Foundation

public struct ResponsePageDTO: Decodable {
    public let total: Int
    public let totalPages: Int
    public let results: [PhotoDTO]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
