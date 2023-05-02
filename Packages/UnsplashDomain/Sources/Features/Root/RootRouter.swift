//
//  RootRouter.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import UIKit
import Foundation

protocol RootInteractable: Interactable {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

public protocol RootViewControllable: ViewControllable { }

final class RootRouter: ViewableRouter<RootInteractable, RootViewControllable>, RootRouting {

    private class Stub: UIViewController, RootViewControllable {}

    private let window: UIWindow

    init(
        window: UIWindow,
        interactor: RootInteractable
    ) {
        self.window = window
        super.init(interactor: interactor, viewController: Stub())
        interactor.router = self
    }

    // MARK: - RootRouting

    func launch() {
        load()
        interactor.activate()
    }
}
