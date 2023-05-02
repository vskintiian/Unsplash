//
//  PhotoDTO.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import Foundation

public struct PhotoDTO: Decodable, Equatable {
    public struct ImageUrl: Decodable, Equatable {
        let regular: String
        let thumb: String
    }

    public let id: String
    public let description: String?
    public let altDescription: String
    public let urls: ImageUrl
    public let user: UserDTO

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case altDescription = "alt_description"
        case urls
        case user
    }
}
