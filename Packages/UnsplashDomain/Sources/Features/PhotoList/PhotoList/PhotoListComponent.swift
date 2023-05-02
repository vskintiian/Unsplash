//
//  PhotoListComponent.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation
import UnsplashCore

protocol PhotoListDependency: Dependency {
    var apiService: APIServicing { get }
}

final class PhotoListComponent: Component<PhotoListDependency> {
func useCase() -> PhotoListUseCaseType {
        shared {
            PhotoListUseCase(apiService: dependency.apiService)
        }
    }
}
