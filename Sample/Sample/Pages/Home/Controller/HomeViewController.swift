//
//  HomeViewController.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import Combine
import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func userDidSelectRowAt(category: Category)
}

class HomeViewController: UIViewController {
    weak var delegate: HomeViewControllerDelegate? = nil
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.observe()
        self.title = "Hello World"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        self.view = HomeView()
    }
}

private extension HomeViewController {
    func observe() {
        guard let view = self.view as? HomeView else {
            return
        }
        
        self.observeRowSelection(publisher: view.userDidSelectRowAtCategory.eraseToAnyPublisher())
    }
    
    func observeRowSelection(publisher: AnyPublisher<Category, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] category in
                self?.delegate?.userDidSelectRowAt(category: category)
            })
            .store(in: &self.cancellables)
    }
}
