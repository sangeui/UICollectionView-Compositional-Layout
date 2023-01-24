//
//  GridLayout.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import UIKit

class GridLayout: UICollectionViewCompositionalLayout {
    init() {
        super.init(section: .section(columns: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Section
private extension NSCollectionLayoutSection {
    static func section(columns: Int) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: .group(columns: columns))
        
        return section
    }
}

// MARK: - Group
private extension NSCollectionLayoutGroup {
    static func group(columns: Int) -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalWidth(1.0 / CGFloat(columns)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       repeatingSubitem: .item(columns: columns),
                                                       count: columns)
        
        return group
    }
}

// MARK: - Item
private extension NSCollectionLayoutItem {
    static func item(columns: Int) -> NSCollectionLayoutItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(columns)),
                                          heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        return item
    }
}
