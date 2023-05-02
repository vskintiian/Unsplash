//
//  PhotoListFlowBuilder.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation

// MARK: - Builder

public protocol PhotoListFlowBuildable: Buildable {
    func build(withListener listener: PhotoListFlowListener) -> PhotoListFlowRouting
}

public final class PhotoListFlowBuilder: Builder<PhotoListFlowDependency>, PhotoListFlowBuildable {

    public override init(dependency: PhotoListFlowDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: PhotoListFlowListener) -> PhotoListFlowRouting {
        let component = PhotoListFlowComponent(dependency: dependency)
        let interactor = PhotoListFlowInteractor(useCase: component.useCase())
        interactor.listener = listener
        let navigationFlowController = PhotoListFlowViewController()
        navigationFlowController.listener = interactor
        return PhotoListFlowRouter(
            interactor: interactor,
            viewController: navigationFlowController,
            photoListBuilder: PhotoListBuilder(dependency: component),
            photoDetailsBuilder: PhotoDetailsBuilder(dependency: component)
        )
    }
}
