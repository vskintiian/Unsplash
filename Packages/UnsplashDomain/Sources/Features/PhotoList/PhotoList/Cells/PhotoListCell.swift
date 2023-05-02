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
        static func == (lhs: PhotoListCell.ViewModel, rhs: PhotoListCell.ViewModel) -> Bool {
            lhs.title == rhs.title && lhs.imageURL == rhs.imageURL
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(title)
            hasher.combine(imageURL)
        }

        let title: String
        let imageURL: URL?
        let action: () -> Void
    }

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!

    private var cancellables = Set<AnyCancellable>()
    private var action: (() -> Void)?

    override var isSelected: Bool {
        didSet {
            guard isSelected else { return }
            action?()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
    }

    func configure(_ viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        action = viewModel.action

        guard let imageURL = viewModel.imageURL else { return }
        imageView.fetchImage(with: imageURL).store(in: &cancellables)
    }
}
