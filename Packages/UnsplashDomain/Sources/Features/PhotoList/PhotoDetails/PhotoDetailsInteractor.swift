//
//  PhotoDetailsInteractor.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Foundation

protocol PhotoDetailsRouting: ViewableRouting { }

protocol PhotoDetailsPresentable: AnyObject {
    var listener: PhotoDetailsPresentableListener? { get set }
}

typealias PhotoDetailsFeedback = PhotoDetailsInteractor.Feedback
protocol PhotoDetailsListener: AnyObject {
    func processPhotoDetailsFeedback(_ feedback: PhotoDetailsFeedback)
}

final class PhotoDetailsInteractor: PresentableInteractor<PhotoDetailsPresentable>, PhotoDetailsInteractable, PhotoDetailsPresentableListener {

    // MARK: - Nested types

    enum Feedback { }

    weak var router: PhotoDetailsRouting?
    weak var listener: PhotoDetailsListener?

    private let useCase: PhotoDetailsUseCaseType

init(presenter: PhotoDetailsPresentable, useCase: PhotoDetailsUseCaseType) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

}
