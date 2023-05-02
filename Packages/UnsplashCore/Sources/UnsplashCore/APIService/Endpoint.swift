//
//  Endpoint.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import Foundation

protocol URLProvidable {
    var url: URL { get }
}

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint: URLProvidable {
    private enum Constants {
        static let host = "api.unsplash.com"
        static let scheme = "https"
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

extension Endpoint {
    static func photos(page: Int, query: String) -> Self {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "client_id", value: "c99a7e7599297260b46b7c9cf36727badeb1d37b1f24aa9ef5d844e3fbed76fe")
        ]
        
        return Endpoint(path: "search/photos", queryItems: queryItems)
    }
}
