//
//  Identifiable.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit

public protocol Identifiable: AnyObject {
    static var identifier: String { get }
}

public extension Identifiable {
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: Identifiable {}
extension UICollectionReusableView: Identifiable {}
extension UIViewController: Identifiable {}
