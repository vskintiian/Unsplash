//
//  PhotoListBuilder.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation
import Extensions

// MARK: - Builder

protocol PhotoListBuildable: Buildable {
    func build(withListener listener: PhotoListListener) -> PhotoListRouting
}

final class PhotoListBuilder: Builder<PhotoListDependency>, PhotoListBuildable {

    override init(dependency: PhotoListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: PhotoListListener) -> PhotoListRouting {
        let component = PhotoListComponent(dependency: dependency)
        let viewController: PhotoListViewController = PhotoListViewController.instantiateFromStoryboard(bundle: .module)
        let interactor = PhotoListInteractor(presenter: viewController, useCase: component.useCase())
        interactor.listener = listener
        return PhotoListRouter(interactor: interactor, viewController: viewController)
    }
}
