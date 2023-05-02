//
//  RootInteractor.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation

public protocol RootRouting: Routing {
    func launch()
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
    }
}
