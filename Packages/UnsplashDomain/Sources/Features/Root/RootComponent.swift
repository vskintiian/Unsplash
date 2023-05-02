//
//  RootComponent.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation

public protocol RootDependency: Dependency { }

public final class RootComponent: Component<RootDependency> {
    public func useCase() -> RootUseCaseType {
        shared {
            RootUseCase()
        }
    }
}
