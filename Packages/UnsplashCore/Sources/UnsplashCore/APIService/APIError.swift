//
//  APIError.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import Foundation

public enum APIError: Error {
    case general(description: String)
    case decoding
    case invalidStatusCode
}
