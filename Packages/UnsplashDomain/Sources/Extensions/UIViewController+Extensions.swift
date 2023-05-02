//
//  UIViewController+Extensions.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit

public extension UIViewController {
    static var storyboardName: String { identifier }

    static func instantiateFromStoryboard<T>(bundle: Bundle) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
        }
        return controller
    }
}
