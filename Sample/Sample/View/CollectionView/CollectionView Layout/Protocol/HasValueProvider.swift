//
//  HasValueProvider.swift
//  Sample
//
//  Created by William on 2023/01/31.
//

import UIKit

protocol HasValueProvider {
    var valueProvider: UICollectionViewCompositionalLayout.ValueProvider { get set }
}
