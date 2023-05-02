//
//  APIService.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import Combine
import Foundation

public protocol APIServicing {
    func getItems(page: Int, searchText: String) -> AnyPublisher<ResponsePageDTO, Error>
}

public final class APIService: APIServicing {
    private let executor: RequestsExecutorType = RequestsExecutor()

    public init() {}

    // MARK: - APIServicing

    public func getItems(page: Int, searchText: String) -> AnyPublisher<ResponsePageDTO, Error> {
        executor.execute(url: Endpoint.photos(page: page, query: searchText).url)
    }
}
