//
//  XScrollableLayoutView.swift
//  Sample
//
//  Created by William on 2023/01/27.
//

import UIKit

class XScrollableLayoutView: UIView {
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension XScrollableLayoutView {
    func setup() {
        self.backgroundColor = .systemBackground
    }
}
