//
//  GridLayoutViewController.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import UIKit

class GridLayoutViewController: UIViewController {
    override func loadView() {
        self.view = GridLayoutView()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "GRID LAYOUT"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.view as? GridLayoutView)?.update(sections: ModelProvider().create(numberOfSections: 3, numberOfItems: 50))
    }
}
