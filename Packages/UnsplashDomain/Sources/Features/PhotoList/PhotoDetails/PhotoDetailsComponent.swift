//
//  PhotoDetailsComponent.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation

protocol PhotoDetailsDependency: Dependency { }

final class PhotoDetailsComponent: Component<PhotoDetailsDependency> {
    func useCase() -> PhotoDetailsUseCaseType {
        shared {
            PhotoDetailsUseCase()
        }
    }
}
