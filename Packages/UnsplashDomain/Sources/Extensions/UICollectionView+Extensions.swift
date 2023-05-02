//
//  UICollectionView+Extensions.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit

public extension UICollectionView {
    func registerCell<T: Identifiable>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }

    func registerNib<T: Identifiable>(_: T.Type, bundle: Bundle) {
        let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            assertionFailure("Failed to dequeue cell with identifier: \(T.identifier)")
            return T()
        }

        return cell
    }

    enum SectionSupplementaryViewType {
        case header, footer

        fileprivate var kind: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        for indexPath: IndexPath,
        supplementaryViewType: SectionSupplementaryViewType
    ) -> T {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: supplementaryViewType.kind,
            withReuseIdentifier: T.identifier,
            for: indexPath) as? T
        else {
            assertionFailure("Failed to dequeue reusable header with identifier: \(T.identifier)")
            return T()
        }

        return view
    }

    func registerSupplementaryView<T: Identifiable>(_: T.Type, supplementaryViewType: SectionSupplementaryViewType) {
        register(T.self, forSupplementaryViewOfKind: supplementaryViewType.kind, withReuseIdentifier: T.identifier)
    }
}
