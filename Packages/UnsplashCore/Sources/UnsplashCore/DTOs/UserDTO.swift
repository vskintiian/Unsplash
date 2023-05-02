//
//  UserDTO.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import Foundation

public struct UserDTO: Decodable, Equatable {
    public struct ProfileImage: Decodable, Equatable {
        let small, medium, large: String
    }

    public let id: String
    public let username: String
    public let name: String
    public let firstName: String
    public let lastName: String?
    public let bio: String?
    public let profileImage: ProfileImage

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
        case profileImage = "profile_image"
    }
}
