//
//  PhotoDetailsComponent.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation
import UnsplashCore

protocol PhotoDetailsDependency: Dependency { }

final class PhotoDetailsComponent: Component<PhotoDetailsDependency> {
    func useCase(photo: PhotoDTO) -> PhotoDetailsUseCaseType {
        shared {
            PhotoDetailsUseCase(photo: photo)
        }
    }
}
