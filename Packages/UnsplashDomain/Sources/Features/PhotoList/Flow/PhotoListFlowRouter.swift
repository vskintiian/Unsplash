//
//  PhotoListFlowRouter.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation
import UnsplashCore

protocol PhotoListFlowInteractable: Interactable, PhotoListListener, PhotoDetailsListener {
    var router: PhotoListFlowRouting? { get set }
    var listener: PhotoListFlowListener? { get set }
}

protocol PhotoListFlowViewControllable: FlowViewControllable { }

final class PhotoListFlowRouter: ViewableFlowRouter<PhotoListFlowInteractable, PhotoListFlowViewControllable>,
                                 PhotoListFlowRouting {

    private let photoListBuilder: PhotoListBuildable
    private let photoDetailsBuilder: PhotoDetailsBuildable

    init(
        interactor: PhotoListFlowInteractable,
        viewController: PhotoListFlowViewControllable,
        photoListBuilder: PhotoListBuildable,
        photoDetailsBuilder: PhotoDetailsBuildable
    ) {
        self.photoListBuilder = photoListBuilder
        self.photoDetailsBuilder = photoDetailsBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func routeToPhotoList() {
        pushAttached(router: photoListBuilder.build(withListener: interactor))
    }

    func routeToPhotoDetails(_ photo: PhotoDTO) {
        pushAttached(router: photoDetailsBuilder.build(withListener: interactor, photo: photo))
    }
}
