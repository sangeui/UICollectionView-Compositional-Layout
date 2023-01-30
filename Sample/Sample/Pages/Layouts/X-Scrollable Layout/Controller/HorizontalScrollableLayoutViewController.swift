//
//  HorizontalScrollableLayoutViewController.swift
//  Sample
//
//  Created by William on 2023/01/27.
//

import UIKit

class XScrollableLayoutViewController: UIViewController {
    override func loadView() {
        self.view = XScrollableLayoutView()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Horizontal Scrollable Layout"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
