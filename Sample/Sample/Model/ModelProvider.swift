//
//  ModelProvider.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import Foundation

struct ModelProvider {
    func create(numberOfSections: Int, numberOfItems: Int) -> [(section: Section, items: [Item])] {
        let sections: [Section] = (1...numberOfSections).map({ _ in return .init(identifier: .init()) })
        let set: [(section: Section, items: [Item])] = sections.map({ section in
            let items: [Item] = (1...numberOfItems).map({ _ in return .random })
            
            return (section, items)
        })
        
        return set
    }
}
