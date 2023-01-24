//
//  Category.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import Foundation

enum Category {
    case grid_layout
    case horizontal_scrollable_layout
    case vertical_scrollable_layout
}

extension Category {
    var title: String {
        return _Category.titles[self] ?? .init()
    }
    
    var iconImageSystemName: String {
        return _Category.iconImageNmaes[self] ?? .init()
    }
}

fileprivate struct _Category {
    static let titles: [Category: String] = [
        .grid_layout: "GRID LAYOUT",
        .horizontal_scrollable_layout: "HORIZONTAL SCROLLABLE LAYOUT",
        .vertical_scrollable_layout: "VERTICAL SCROLLABLE LAYOUT"
    ]
    
    static let iconImageNmaes: [Category: String] = [
        .grid_layout: "square.grid.3x3.square",
        .horizontal_scrollable_layout: "arrow.left.and.right.square.fill",
        .vertical_scrollable_layout: "arrow.up.and.down.square.fill"
    ]
}
