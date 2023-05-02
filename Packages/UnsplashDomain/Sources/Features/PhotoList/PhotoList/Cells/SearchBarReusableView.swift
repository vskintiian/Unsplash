//
//  SearchBarReusableView.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit

protocol SearchBarViewDelegate {
    func didChangedInput(_ input: String)
    func didClickedSearchButton()
}

final class SearchBarReusableView: UICollectionReusableView {
    private var delegate: SearchBarViewDelegate?

    private lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.tintColor = UIColor.black
        searchBar.placeholder = "Search..."
        searchBar.backgroundColor = UIColor.clear
        searchBar.barTintColor = UIColor.clear
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .search
        searchBar.showsCancelButton = false
        searchBar.showsBookmarkButton = false

        return searchBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        delegate = nil
    }

    func configure(currentText: String, delegate: SearchBarViewDelegate) {
        searchBarView.text = currentText
        self.delegate = delegate
    }

    func setupUI() {
        addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor),
            trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor),
            topAnchor.constraint(equalTo: searchBarView.topAnchor),
            bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor)
        ])

        searchBarView.delegate = self
    }
}

extension SearchBarReusableView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didChangedInput(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarView.resignFirstResponder()
        delegate?.didClickedSearchButton()
    }
}
