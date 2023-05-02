//
//  PhotoListFlowInteractor.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation

public protocol PhotoListFlowRouting: ViewableFlowRouting {
    func routeToPhotoList()
}

protocol PhotoListFlowPresentable: AnyObject {
    var listener: PhotoListFlowPresentableListener? { get set }
}

public typealias PhotoListFlowFeedback = PhotoListFlowInteractor.Feedback
public protocol PhotoListFlowListener: AnyObject {
    func processPhotoListFeedback(_ feedback: PhotoListFlowFeedback)
}

public final class PhotoListFlowInteractor: FlowInteractor, PhotoListFlowInteractable, PhotoListFlowPresentableListener {

    // MARK: - Nested types

    public enum Feedback { }

    // MARK: - Public properties

    weak var router: PhotoListFlowRouting? {
        didSet {
            flowRouter = router
        }
    }

    weak var listener: PhotoListFlowListener?

    // MARK: - Private properties

    private let useCase: PhotoListFlowUseCaseType

    // MARK: - Life cycle

    public init(useCase: PhotoListFlowUseCaseType) {
        self.useCase = useCase
    }

    public override func didBecomeActive() {
        super.didBecomeActive()
        router?.routeToPhotoList()
    }
}

// MARK: - PhotoListListener

extension PhotoListFlowInteractor {
    func processPhotoListFeedback(_ feedback: PhotoListFeedback) {
        switch feedback { }
    }
}
