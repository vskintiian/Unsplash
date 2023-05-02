//
//  PhotoListRouter.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation

protocol PhotoListInteractable: Interactable {
    var router: PhotoListRouting? { get set }
    var listener: PhotoListListener? { get set }
}

protocol PhotoListViewControllable: ViewControllable { }

final class PhotoListRouter: ViewableRouter<PhotoListInteractable, PhotoListViewControllable>, PhotoListRouting {

    override init(interactor: PhotoListInteractable, viewController: PhotoListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
