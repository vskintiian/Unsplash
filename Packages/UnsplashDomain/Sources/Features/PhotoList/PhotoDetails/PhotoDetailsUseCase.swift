//
//  PhotoDetailsUseCase.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import Foundation
import UnsplashCore

protocol PhotoDetailsUseCaseType {
    var photo: PhotoDTO { get }
}

final class PhotoDetailsUseCase: PhotoDetailsUseCaseType {

    // MARK: - PhotoDetailsUseCaseType

    let photo: PhotoDTO

    init(photo: PhotoDTO) {
        self.photo = photo
    }
}
