//
//  PhotoListFlowViewController.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit

protocol PhotoListFlowPresentableListener: AnyObject { }

final class PhotoListFlowViewController: UINavigationController, PhotoListFlowPresentable, PhotoListFlowViewControllable {

    weak var listener: PhotoListFlowPresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()

        // setNavigationBarHidden(true, animated: false)
    }
}
