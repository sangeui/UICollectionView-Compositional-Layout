//
//  GridLayoutView.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import Combine
import UIKit

class GridLayoutView: UIView {
    private let stackView: UIStackView = .init()
    
    private let sliderView: UISliderView = .init(configuration: .init(minimum: 1, maximum: 10, default: 1))
    private let interGroupSliderView: UISliderView = .init(configuration: .init(minimum: .zero, maximum: 10, default: .zero))
    private let interItemSliderView: UISliderView = .init(configuration: .init(minimum: .zero, maximum: 10, default: .zero))
    private let interSectionSliderView: UISliderView = .init(configuration: .init(minimum: .zero, maximum: 10, default: .zero))
    
    private lazy var collectionView: UICollectionView = CollectionView(collectionViewLayout: self.gridLayout)
    private lazy var dataSource: GridLayoutDataSource = .init(collectionView: self.collectionView)
    private lazy var gridLayout: GridLayout = .init(columnsProvider: { [weak self] in
        return .init(numberOfColumns: .init(self?.sliderView.valueChanged.value ?? 1),
                     interGroupSpacing: .init(self?.interGroupSliderView.valueChanged.value ?? .zero),
                     interItemSpacing: .init(self?.interItemSliderView.valueChanged.value ?? .zero))
    })
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        super.init(frame: .zero)
        self.setup()
        self.observe()
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

private extension GridLayoutView {
    func observe() {
        self.observeSliderValueChanged(publisher: self.sliderView.valueChanged.eraseToAnyPublisher())
        self.observeSliderValueChanged(publisher: self.interGroupSliderView.valueChanged.eraseToAnyPublisher())
        self.observeSliderValueChanged(publisher: self.interItemSliderView.valueChanged.eraseToAnyPublisher())
        self.observeInterSectionSpacingChanged(publisher: self.interSectionSliderView.valueChanged.eraseToAnyPublisher())
    }
    
    func observeSliderValueChanged(publisher: AnyPublisher<Int, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.collectionView.collectionViewLayout.invalidateLayout()
            })
            .store(in: &self.cancellables)
    }
    
    func observeInterSectionSpacingChanged(publisher: AnyPublisher<Int, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                (self?.collectionView.collectionViewLayout as? GridLayout)?.update(interSectionSpacing: .init(value))
            })
            .store(in: &self.cancellables)
    }
}

private extension GridLayoutView {
    func setup() {
        self.backgroundColor = .systemGroupedBackground
        self.setupStackView(view: self.stackView)
        self.setupSliderView(view: self.sliderView)
        self.setupInterSectionSpacingSliderView(view: self.interSectionSliderView)
        self.setupInterGroupSpacingSliderView(view: self.interGroupSliderView)
        self.setupInterItemSpacingSliderView(view: self.interItemSliderView)
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
    
    func setupSliderView(view: UISliderView) {
        self.stackView.addArrangedSubview(view)
        
        view.slider.minimumValueImage = .init(systemName: "circlebadge.fill")
        view.primaryText = "NUMBER OF COLUMNS"
    }
    
    func setupInterGroupSpacingSliderView(view: UISliderView) {
        self.stackView.addArrangedSubview(view)
        
        view.slider.minimumValueImage = .init(systemName: "circlebadge.fill")
        view.primaryText = "INTER GROUP SPACING"
    }
    
    func setupInterItemSpacingSliderView(view: UISliderView) {
        self.stackView.addArrangedSubview(view)
        
        view.slider.minimumValueImage = .init(systemName: "circlebadge.fill")
        view.primaryText = "INTER ITEM SPACING"
    }
    
    func setupInterSectionSpacingSliderView(view: UISliderView) {
        self.stackView.addArrangedSubview(view)
        
        view.slider.minimumValueImage = .init(systemName: "circlebadge.fill")
        view.primaryText = "INTER SECTION SPACING"
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
