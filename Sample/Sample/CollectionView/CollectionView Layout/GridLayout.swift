//
//  GridLayout.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import UIKit

struct GridLayoutConfigurationValue {
    let numberOfColumns: CGFloat
    let interGroupSpacing: CGFloat
    let interItemSpacing: CGFloat
}

class GridLayout: UICollectionViewCompositionalLayout {
    init(columnsProvider: @escaping (() -> GridLayoutConfigurationValue)) {
        super.init(sectionProvider: { _,_ in
            return .section(value: columnsProvider())
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func update() {
        self.invalidateLayout()
    }
}

// MARK: - Section
private extension NSCollectionLayoutSection {
    static func section(value: GridLayoutConfigurationValue) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: .group(value: value))
        section.interGroupSpacing = value.interGroupSpacing
        
        return section
    }
}

// MARK: - Group
private extension NSCollectionLayoutGroup {
    static func group(value: GridLayoutConfigurationValue) -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalWidth(1.0 / value.numberOfColumns))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       repeatingSubitem: .item(value: value),
                                                       count: Int(value.numberOfColumns))
        group.interItemSpacing = .fixed(value.interItemSpacing)
        
        return group
    }
}

// MARK: - Item
private extension NSCollectionLayoutItem {
    static func item(value: GridLayoutConfigurationValue) -> NSCollectionLayoutItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / value.numberOfColumns),
                                          heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        return item
    }
}
