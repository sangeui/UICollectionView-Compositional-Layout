//
//  GridLayoutView.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import Combine
import UIKit

class LayoutView: UIView {
    typealias UICollectionViewCompositionalLayoutWithValueProvider = UICollectionViewCompositionalLayout & HasValueProvider
    
    // MARK: - 레이아웃 값 제공자
    let layoutValueProvider: UICollectionViewCompositionalLayout.ValueProvider
    
    // MARK: - 유저 인터페이스
    let stackView: UIStackView = .init()
    let collectionView: UICollectionView
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    private let dataSource: GridLayoutDataSource
    
    init(layout: UICollectionViewCompositionalLayoutWithValueProvider) {
        let collectionView = CollectionView(collectionViewLayout: layout)
        
        self.layoutValueProvider = layout.valueProvider
        self.collectionView = collectionView
        self.dataSource = .init(collectionView: collectionView)
        
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func update(sections: [(Section, [Item])]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        sections.forEach { (section, item) in
            snapshot.appendSections([section])
            snapshot.appendItems(item, toSection: section)
        }
        
        self.dataSource.apply(snapshot)
    }
}

extension LayoutView {
    func observeSliderValueChanged(publisher: UISliderView<UISliderViewType>.Publisher) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (value, type) in
                switch type {
                case .numberOfColumns:
                    self?.layoutValueProvider.update(numberOfColumns: .init(value))
                case .interSectionSpacing:
                    (self?.collectionView.collectionViewLayout as? GridCollectionViewCompositionalLayout)?.update(interSectionSpacing: .init(value))
                case .interGroupSpacing:
                    self?.layoutValueProvider.update(interGroupSpacing: .init(value))
                case .interItemSpacing:
                    self?.layoutValueProvider.update(interItemSpacing: .init(value))
                }
                
                self?.collectionView.collectionViewLayout.invalidateLayout()
            })
            .store(in: &self.cancellables)
    }
}

private extension LayoutView {
    func setup() {
        self.backgroundColor = .systemGroupedBackground
        self.setupStackView(view: self.stackView)
        self.setupCollectionView(view: self.collectionView)
    }
    
    func setupStackView(view: UIStackView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemBackground
        view.axis = .vertical
    }
    
    func setupCollectionView(view: UICollectionView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 10).isActive = true
        view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.register(CollectionViewGridLayoutCell.self,
                      forCellWithReuseIdentifier: CollectionViewGridLayoutCell.identifier)
    }
}
