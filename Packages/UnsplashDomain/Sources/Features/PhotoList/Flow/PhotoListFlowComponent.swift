//
//  PhotoListFlowComponent.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation
import UnsplashCore

public protocol PhotoListFlowDependency: Dependency {
    var apiService: APIServicing { get }
}

public final class PhotoListFlowComponent: Component<PhotoListFlowDependency> {
    public func useCase() -> PhotoListFlowUseCaseType {
        shared {
            PhotoListFlowUseCase()
        }
    }
}

extension PhotoListFlowComponent: PhotoListDependency {
    var apiService: APIServicing { dependency.apiService }
}
