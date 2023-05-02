//
//  Collection+Extensions.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import Foundation

public extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
