//
//  PhotoDetailsViewController.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit
import Combine
import Extensions

protocol PhotoDetailsPresentableListener: AnyObject {
    var viewModel: PhotoDetailsViewController.ViewModel? { get }
}

final class PhotoDetailsViewController: UIViewController, PhotoDetailsPresentable, PhotoDetailsViewControllable {

    // MARK: - Nested Types

    struct ViewModel {
        let photoImageURL: URL
        let userImageURL: URL
        let photoDescription: String
        let userFullName: String
        let userName: String
        let userBio: String
    }

    @IBOutlet private var photoImageView: DynamicSizeFitImageView!
    @IBOutlet private var userImageView: UIImageView!
    @IBOutlet private var photoDescriptionLabel: UILabel!
    @IBOutlet private var userFullNameLabel: UILabel!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var userBioLabel: UILabel!

    private var cancellables = Set<AnyCancellable>()

    weak var listener: PhotoDetailsPresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        guard let viewModel = listener?.viewModel else { return }

        photoImageView.fetchImage(with: viewModel.photoImageURL).store(in: &cancellables)
        userImageView.fetchImage(with: viewModel.userImageURL).store(in: &cancellables)
        photoDescriptionLabel.text = viewModel.photoDescription
        userFullNameLabel.text = viewModel.userFullName
        userNameLabel.text = viewModel.userName
        userBioLabel.text = viewModel.userBio
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
    }
}
