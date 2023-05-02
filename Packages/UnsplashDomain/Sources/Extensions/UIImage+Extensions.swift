//
//  File.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit
import Combine
import UnsplashCore

public extension UIImageView {
    static var imageFetchService: ImageFetchServicing?

    func fetchImage(with url: URL) -> AnyCancellable {
        guard let fetchService = Self.imageFetchService else {
            return .init({ })
        }

        return fetchService.fetchImage(url: url).sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] (url, image) in
                guard let self else { return }
                DispatchQueue.main.async { self.image = image }
            }
        )
    }
}
