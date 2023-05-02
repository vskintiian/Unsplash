//
//  PhotoListCell.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit
import Combine
import Foundation
import Extensions

final class PhotoListCell: UICollectionViewCell {
    struct ViewModel: Hashable {
        let title: String
        let imageURL: URL
    }

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!

    private var cancellables = Set<AnyCancellable>()

    func configure(_ viewModel: ViewModel) {
        titleLabel.text = viewModel.title

        imageView.fetchImage(with: viewModel.imageURL)
            .store(in: &cancellables)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }
}
