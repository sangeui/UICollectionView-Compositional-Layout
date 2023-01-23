//
//  Section.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import Foundation

struct Section: Hashable {
    // 식별자
    private let identifier: UUID
    
    init() {
        self.identifier = .init()
    }
    
    init(identifier: UUID) {
        self.identifier = identifier
    }
}
