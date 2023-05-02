//
//  PhotoDetailsBuilder.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation

// MARK: - Builder

protocol PhotoDetailsBuildable: Buildable {
    func build(withListener listener: PhotoDetailsListener) -> PhotoDetailsRouting
}

final class PhotoDetailsBuilder: Builder<PhotoDetailsDependency>, PhotoDetailsBuildable {

    override init(dependency: PhotoDetailsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: PhotoDetailsListener) -> PhotoDetailsRouting {
        let component = PhotoDetailsComponent(dependency: dependency)
        let viewController: PhotoDetailsViewController = PhotoDetailsViewController.instantiateFromStoryboard(bundle: .module)
        let interactor = PhotoDetailsInteractor(presenter: viewController, useCase: component.useCase())
        interactor.listener = listener
        return PhotoDetailsRouter(interactor: interactor, viewController: viewController)
    }
}
