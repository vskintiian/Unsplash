//
//  RootInteractor.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation
import PhotoList

public protocol RootRouting: Routing {
    func launch()
    func routeToPhotoList()
}

public typealias RootFeedback = RootInteractor.Feedback
public protocol RootListener: AnyObject {
    func processRootFeedback(_ feedback: RootFeedback)
}

public final class RootInteractor: Interactor, RootInteractable {

    public enum Feedback { }

    weak var router: RootRouting?
    weak var listener: RootListener?

    public init(useCase: RootUseCaseType) {

    }

    public override func didBecomeActive() {
        super.didBecomeActive()
        router?.routeToPhotoList()
    }
}

// MARK: - PhotoListFlowListener

extension RootInteractor {
    public func processPhotoListFeedback(_ feedback: PhotoListFlowFeedback) {
        switch feedback { }
    }
}
