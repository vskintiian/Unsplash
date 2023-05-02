//
//  PhotoListInteractor.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import RIBs
import Combine
import Foundation
import UnsplashCore

protocol PhotoListRouting: ViewableRouting { }

protocol PhotoListPresentable: AnyObject {
    var listener: PhotoListPresentableListener? { get set }
}

typealias PhotoListFeedback = PhotoListInteractor.Feedback
protocol PhotoListListener: AnyObject {
    func processPhotoListFeedback(_ feedback: PhotoListFeedback)
}

final class PhotoListInteractor: PresentableInteractor<PhotoListPresentable>,
                                 PhotoListInteractable,
                                 PhotoListPresentableListener {

    // MARK: - Nested types

    enum Feedback {
        case didSelectItem(PhotoDTO)
    }

    private enum Constants {
        static let loadingOffset = 10
    }

    typealias State = PhotoListViewController.State

    weak var router: PhotoListRouting?
    weak var listener: PhotoListListener?

    private let useCase: PhotoListUseCaseType
    private var cancellables = Set<AnyCancellable>()

    let state: CurrentValueSubject<State, Never> = .init(.idle)

    init(presenter: PhotoListPresentable, useCase: PhotoListUseCaseType) {
        self.useCase = useCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        setupBindings()
        useCase.start()
    }

    private func setupBindings() {
        useCase.state
            .removeDuplicates()
            .sink(receiveValue: { [unowned self] newState in
                switch newState {
                case .idle:
                    state.send(.idle)
                case .loadingMore(let state), .started(let state), .startedThereIsMore(let state):
                    setStartedState(state)
                }
            })
            .store(in: &cancellables)
    }

    // MARK: - PhotoListPresentableListener

    func searchButtonDidTap() {
        useCase.start()
    }

    func searchInputDidChange(_ input: String) {
        useCase.searchText.send(input)
    }

    func loadMore(lastVisibleIndex index: Int) {
        guard case let .started(currentState) = state.value,
              currentState.resourceItems.count - index < Constants.loadingOffset else { return }

        useCase.loadMore()
    }

    // MARK: - Private

    private func setStartedState(_ newState: PhotoListUseCase.StartedState) {
        let resourceItems: [PhotoListCell.ViewModel] = newState.items.map { photo in
            PhotoListCell.ViewModel(
                title: photo.description ?? photo.altDescription ?? "",
                imageURL: URL(string: photo.urls.thumb),
                action: { [weak self] in
                    self?.listener?.processPhotoListFeedback(.didSelectItem(photo))
                }
            )
        }

        state.send(.started(.init(searchText: newState.searchText, resourceItems: resourceItems)))
    }
}
