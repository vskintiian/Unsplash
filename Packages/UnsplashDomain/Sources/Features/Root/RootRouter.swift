//
//  RootRouter.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import UIKit
import Foundation
import PhotoList

protocol RootInteractable: Interactable, PhotoListFlowListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

public protocol RootViewControllable: ViewControllable { }

final class RootRouter: ViewableRouter<RootInteractable, RootViewControllable>, RootRouting {

    private class Stub: UIViewController, RootViewControllable {}

    private let fadeTransition = UIWindow.Transition(duration: 0.2)

    private let window: UIWindow
    private let photoListBuilder: PhotoListFlowBuildable

    init(
        window: UIWindow,
        interactor: RootInteractable,
        photoListBuilder: PhotoListFlowBuildable
    ) {
        self.window = window
        self.photoListBuilder = photoListBuilder
        super.init(interactor: interactor, viewController: Stub())
        interactor.router = self
    }

    // MARK: - RootRouting

    func launch() {
        load()
        interactor.activate()
    }

    func routeToPhotoList() {
        showAttached(
            router: photoListBuilder.build(withListener: interactor),
            with: .asRoot(in: window, with: fadeTransition)
        )
    }

}
