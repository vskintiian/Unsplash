//
//  PhotoListViewController.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit
import Combine

protocol PhotoListPresentableListener: AnyObject {
    var state: CurrentValueSubject<PhotoListViewController.State, Never> { get }

    func searchButtonDidTap()
    func searchInputDidChange(_ input: String)
    func loadMore(lastVisibleIndex index: Int)
}

final class PhotoListViewController: UIViewController, PhotoListPresentable, PhotoListViewControllable {

    // MARK: - Nested Types

    private typealias Item = PhotoListCell.ViewModel
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Item>
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Item>

    enum State {
        struct ViewModel {
            let searchText: String
            let resourceItems: [PhotoListCell.ViewModel]
        }

        case idle
        case started(ViewModel)

        var searchText: String {
            switch self {
            case .idle:
                return ""
            case .started(let state):
                return state.searchText
            }
        }
    }

    @IBOutlet private var collectionView: UICollectionView!

    private lazy var dataSource = makeDataSource()
    private var cancellables = Set<AnyCancellable>()

    weak var listener: PhotoListPresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.collectionViewLayout = makeLayout()
        collectionView.registerNib(PhotoListCell.self, bundle: .module)
        collectionView.registerNib(SearchBarReusableView.self, bundle: .module)
        collectionView.registerSupplementaryView(SearchBarReusableView.self, supplementaryViewType: .header)
    }

    func makeLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }

    // MARK: - Private

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item -> UICollectionViewCell? in
                let cell: PhotoListCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(item)
                return cell
            }
        )

        dataSource.supplementaryViewProvider = { [weak self] collectionView, _, indexPath -> UICollectionReusableView? in
            guard let self, let listener = self.listener else { return nil }

            let headerView: SearchBarReusableView = collectionView.dequeueReusableSupplementaryView(
                for: indexPath,
                supplementaryViewType: .header
            )
            headerView.configure(currentText: listener.state.value.searchText, delegate: self)
            return headerView
        }

        return dataSource
    }

    private func setupBindings() {
        listener?.state
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] state in
                switch state {
                case .idle:
                    break
                case .started(let startedState):
                    var snapshot = Snapshot()
                    snapshot.appendSections([0])
                    snapshot.appendItems(startedState.resourceItems, toSection: 0)
                    dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
                }
            }
            .store(in: &cancellables)
    }
}

extension PhotoListViewController: SearchBarViewDelegate {
    func didChangedInput(_ input: String) {
        listener?.searchInputDidChange(input)
    }

    func didClickedSearchButton() {
        listener?.searchButtonDidTap()
    }
}

extension PhotoListViewController: UICollectionViewDelegateFlowLayout {
    private enum Constants {
        static let photoListCellHeight: CGFloat = 120
        static let defaultHeaderHeight: CGFloat = 44
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        .init(width: collectionView.bounds.width, height: Constants.photoListCellHeight)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard indexPath.section == 0 else { return }
        listener?.loadMore(lastVisibleIndex: indexPath.item)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        .init(width: collectionView.bounds.width, height: Constants.defaultHeaderHeight)
    }
}
