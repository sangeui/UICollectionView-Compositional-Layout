//
//  UICollectionViewCompositionalLayout+Extension.swift
//  Sample
//
//  Created by William on 2023/01/30.
//

import UIKit

extension UICollectionViewCompositionalLayout {
    class ValueProvider {
        private(set) var value: Value = .zero
        
        func update(numberOfColumns: CGFloat) {
            self.value.numberOfColumns = numberOfColumns
        }
        
        func update(interGroupSpacing: CGFloat) {
            self.value.interGroupSpacing = interGroupSpacing
        }
        
        func update(interItemSpacing: CGFloat) {
            self.value.interItemSpacing = interItemSpacing
        }
    }
}


extension UICollectionViewCompositionalLayout {
    struct Value {
        var numberOfColumns: CGFloat
        var interGroupSpacing: CGFloat
        var interItemSpacing: CGFloat
    }
}

extension UICollectionViewCompositionalLayout.Value {
    static let zero: Self = .init(numberOfColumns: 1, interGroupSpacing: .zero, interItemSpacing: .zero)
}
