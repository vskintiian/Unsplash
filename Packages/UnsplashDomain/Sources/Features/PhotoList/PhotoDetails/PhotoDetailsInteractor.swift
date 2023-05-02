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

final class PhotoDetailsInteractor: PresentableInteractor<PhotoDetailsPresentable>,
                                    PhotoDetailsInteractable,
                                    PhotoDetailsPresentableListener {

    // MARK: - Nested types

    enum Feedback { }

    weak var router: PhotoDetailsRouting?
    weak var listener: PhotoDetailsListener?

    private let useCase: PhotoDetailsUseCaseType

    // MARK: - PhotoDetailsPresentableListener

    var viewModel: PhotoDetailsViewController.ViewModel? {
        guard let photoImageURL = URL(string: useCase.photo.urls.regular),
              let userImageURL = URL(string: useCase.photo.user.profileImage.medium) else { return nil }

        return .init(
            photoImageURL: photoImageURL,
            userImageURL: userImageURL,
            photoDescription: useCase.photo.description ?? useCase.photo.altDescription ?? "No description 😔",
            userFullName: useCase.photo.user.name,
            userName: useCase.photo.user.username,
            userBio: useCase.photo.user.bio ?? "No bio 😔"
        )
    }

    init(presenter: PhotoDetailsPresentable, useCase: PhotoDetailsUseCaseType) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }
}
