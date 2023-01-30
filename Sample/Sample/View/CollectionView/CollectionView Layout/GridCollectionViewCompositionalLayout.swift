//
//  GridLayout.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import UIKit



class GridCollectionViewCompositionalLayout: UICollectionViewCompositionalLayout, HasValueProvider {
    var valueProvider: ValueProvider
    
    init(layoutValueProvider: ValueProvider = .init()) {
        self.valueProvider = layoutValueProvider
        
        super.init(sectionProvider: { sectionIndex, environment in
            return .section(value: layoutValueProvider.value)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func update(interSectionSpacing: CGFloat) {
        let configuration = self.configuration
        configuration.interSectionSpacing = interSectionSpacing
        
        self.configuration = configuration
    }
}

// MARK: - Section
private extension NSCollectionLayoutSection {
    static func section(value: UICollectionViewCompositionalLayout.Value) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: .group(value: value))
        section.interGroupSpacing = value.interGroupSpacing
        
        return section
    }
}

// MARK: - Group
private extension NSCollectionLayoutGroup {
    static func group(value: UICollectionViewCompositionalLayout.Value) -> NSCollectionLayoutGroup {
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
    static func item(value: UICollectionViewCompositionalLayout.Value) -> NSCollectionLayoutItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / value.numberOfColumns),
                                          heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        return item
    }
}
