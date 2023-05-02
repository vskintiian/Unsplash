//
//  PhotoListUseCase.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import Combine
import Foundation
import UnsplashCore

protocol PhotoListUseCaseType {
    var state: CurrentValueSubject<PhotoListUseCase.State, Never> { get }
    var searchText: CurrentValueSubject<String, Never> { get }

    func start()
    func loadMore()
}

final class PhotoListUseCase: PhotoListUseCaseType {
    enum State: Equatable {
        case idle
        case loadingMore(StartedState)
        case startedThereIsMore(StartedState)
        case started(StartedState)
    }

    struct StartedState: Equatable {
        let searchText: String
        let items: [PhotoDTO]
    }

    private let apiService: APIServicing
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1

    init(apiService: APIServicing) {
        self.apiService = apiService
    }

    // MARK: - PhotoListUseCaseType

    let state: CurrentValueSubject<State, Never> = .init(.idle)
    let searchText: CurrentValueSubject<String, Never> = .init("")

    func start() {
        guard case .idle = state.value else { return }

        searchText.removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { [unowned self] searchText in
                apiService.getItems(page: currentPage, searchText: searchText)
            }
            .switchToLatest()
            .sink(
                receiveCompletion: { [unowned self] completion in
                    guard case .failure = completion else { return }
                    state.send(.startedThereIsMore(.init(searchText: searchText.value, items: [])))
//                    _failure.accept($0)
                },
                receiveValue: { [unowned self] page in
                    page.totalPages > self.currentPage
                        ? state.send(.startedThereIsMore(.init(searchText: searchText.value, items: page.results)))
                        : state.send(.started(.init(searchText: searchText.value, items: page.results)))
                }
            )
            .store(in: &cancellables)
    }

    func loadMore() {
        guard case let .startedThereIsMore(currentState) = state.value else { return }

        state.send(.loadingMore(currentState))

        let nextPage = currentPage + 1
        apiService.getItems(page: nextPage, searchText: searchText.value)
            .sink(
                receiveCompletion: { [unowned self] completion in
                    guard case .failure = completion else { return }

                    state.send(.startedThereIsMore(.init(searchText: searchText.value, items: currentState.items)))
//                    _failure.accept($0)
                },
                receiveValue: { [unowned self] page in
                    let items = currentState.items + page.results

                    if page.totalPages > nextPage {
                        state.send(.startedThereIsMore(.init(searchText: searchText.value, items: items)))
                        self.currentPage = nextPage
                    } else {
                        state.send(.started(.init(searchText: searchText.value, items: items)))
                    }
                }
            )
            .store(in: &cancellables)
    }
}
