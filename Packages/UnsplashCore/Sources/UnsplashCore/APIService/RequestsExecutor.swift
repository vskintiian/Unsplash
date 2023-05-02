//
//  RequestsExecutor.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import Combine
import Foundation

protocol RequestsExecutorType {
    func execute<T: Decodable>(url: URL) -> AnyPublisher<T, Error>
    func executeData(url: URL) -> AnyPublisher<Data, Error>
}

final class RequestsExecutor: RequestsExecutorType {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func execute<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        executeData(url: url)
            .tryMap { data in try JSONDecoder().decode(T.self, from: data) }
            .eraseToAnyPublisher()
    }
    
    func executeData(url: URL) -> AnyPublisher<Data, Error> {
        session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let response = (response as? HTTPURLResponse), 200...299 ~= response.statusCode else {
                    throw APIError.invalidStatusCode
                }
                
                return data
            }
            .eraseToAnyPublisher()
    }
}

