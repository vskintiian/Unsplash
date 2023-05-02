//
//  ImageFetchService.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit
import Combine

public protocol ImageFetchServicing {
    func fetchImage(url: URL) -> AnyPublisher<(URL, UIImage), Error>
}

public final class ImageFetchService: ImageFetchServicing {
    private static let imageCache = NSCache<NSString, UIImage>()

    private let executor: RequestsExecutorType = RequestsExecutor()

    public init() {}

    // MARK: - ImageFetchServicing

    public func fetchImage(url: URL) -> AnyPublisher<(URL, UIImage), Error> {
        let key = url.absoluteString as NSString

        if let cachedImage = ImageFetchService.imageCache.object(forKey: key) {
            return Just((url, cachedImage)).setFailureType(to: Error.self).eraseToAnyPublisher()
        }

        return executor.executeData(url: url)
            .flatMap { data -> AnyPublisher<(URL, UIImage), Error> in
                guard let image = UIImage(data: data) else {
                    return Fail(error: APIError.decoding).eraseToAnyPublisher()
                }

                ImageFetchService.imageCache.setObject(image, forKey: key)
                return Just((url, image)).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
