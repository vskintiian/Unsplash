//
//  PhotoListFlowRouter.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation

protocol PhotoListFlowInteractable: Interactable, PhotoListListener {
    var router: PhotoListFlowRouting? { get set }
    var listener: PhotoListFlowListener? { get set }
}

protocol PhotoListFlowViewControllable: FlowViewControllable { }

final class PhotoListFlowRouter: ViewableFlowRouter<PhotoListFlowInteractable, PhotoListFlowViewControllable>,
                                 PhotoListFlowRouting {

    private let photoListBuilder: PhotoListBuildable

    init(
        interactor: PhotoListFlowInteractable,
        viewController: PhotoListFlowViewControllable,
        photoListBuilder: PhotoListBuildable
    ) {
        self.photoListBuilder = photoListBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func routeToPhotoList() {
        pushAttached(router: photoListBuilder.build(withListener: interactor))
    }
}
