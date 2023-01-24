//
//  GridLayout.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import UIKit

class GridLayout: UICollectionViewCompositionalLayout {
    init() {
        super.init(section: .init(group: .horizontal(layoutSize: .init(widthDimension: .absolute(1), heightDimension: .absolute(1)), subitems: [.init(layoutSize: .init(widthDimension: .absolute(1), heightDimension: .absolute(1)))])))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
