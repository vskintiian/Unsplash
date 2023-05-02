//
//  RootComponent.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import PhotoList
import Foundation
import UnsplashCore

public protocol RootDependency: Dependency {
    var apiService: APIServicing { get }
}

public final class RootComponent: Component<RootDependency> {
    public func useCase() -> RootUseCaseType {
        shared {
            RootUseCase()
        }
    }
}

extension RootComponent: PhotoListFlowDependency {
    public var apiService: APIServicing { dependency.apiService }
}
