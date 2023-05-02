//
//  PhotoDetailsViewController.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit

protocol PhotoDetailsPresentableListener: AnyObject { }

final class PhotoDetailsViewController: UIViewController, PhotoDetailsPresentable, PhotoDetailsViewControllable {

    weak var listener: PhotoDetailsPresentableListener?
}
