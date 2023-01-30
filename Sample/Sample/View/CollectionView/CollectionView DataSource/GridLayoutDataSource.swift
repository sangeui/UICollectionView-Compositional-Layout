//
//  GridLayoutDataSource.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import UIKit

class GridLayoutDataSource: UICollectionViewDiffableDataSource<Section, Item> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let identifier = CollectionViewGridLayoutCell.identifier
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CollectionViewGridLayoutCell else {
                return nil
            }
            
            cell.backgroundColor = .init(red: itemIdentifier.color.red / 255,
                                         green: itemIdentifier.color.green / 255,
                                         blue: itemIdentifier.color.blue / 255,
                                         alpha: 1.0)
            
            return cell
        }
    }
}
