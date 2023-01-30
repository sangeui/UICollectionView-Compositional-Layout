//
//  CollectionView.swift
//  Sample
//
//  Created by William on 2023/01/23.
//

import UIKit

class CollectionView: UICollectionView {
    init(collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
