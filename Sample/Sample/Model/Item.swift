//
//  Item.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import Foundation

struct Item {
    // 식별자
    private let identifier: UUID
    
    // 기타 프로퍼티
    private let color: Color
    
    init(color: Color) {
        self.identifier = .init()
        self.color = color
    }
    
    init(identifier: UUID) {
        self.identifier = identifier
        self.color = (.zero, .zero, .zero)
    }
}

// MARK: - Type Alias
extension Item {
    typealias Color = (red: CGFloat, green: CGFloat, blue: CGFloat)
}

// MARK: - Equatable
extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

// MARK: - Hashable
extension Item: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }
}
