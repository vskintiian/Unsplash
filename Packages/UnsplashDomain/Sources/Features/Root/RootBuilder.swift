//
//  RootBuilder.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import UIKit
import Foundation

// MARK: - Builder

public protocol RootBuildable: Buildable {
    func build(with window: UIWindow) -> RootRouting
}

public final class RootBuilder: Builder<RootDependency>, RootBuildable {

    public override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    public func build(with window: UIWindow) -> RootRouting {
        let component = RootComponent(dependency: dependency)
        let interactor = RootInteractor(useCase: component.useCase())
        return RootRouter(window: window, interactor: interactor)
    }
}
