//
//  GridLayoutView.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import Combine
import UIKit

class GridLayoutView: UIView {
    private let sliderView: UISliderView = .init()
    private lazy var collectionView: UICollectionView = CollectionView(collectionViewLayout: self.gridLayout)
    private lazy var dataSource: GridLayoutDataSource = .init(collectionView: self.collectionView)
    private lazy var gridLayout: GridLayout = .init(columnsProvider: { [weak self] in
        return self?.sliderView.valueChanged.value ?? 1
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
        self.obseveSliderValueChanged(publisher: self.sliderView.valueChanged.eraseToAnyPublisher())
    }
    
    func obseveSliderValueChanged(publisher: AnyPublisher<Int, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.collectionView.collectionViewLayout.invalidateLayout()
            })
            .store(in: &self.cancellables)
    }
}

private extension GridLayoutView {
    func setup() {
        self.backgroundColor = .systemGroupedBackground
        self.setupSliderView(view: self.sliderView)
        self.setupCollectionView(view: self.collectionView)
    }
    
    func setupSliderView(view: UISliderView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemBackground
        
        view.slider.minimumValueImage = .init(systemName: "squareshape.split.2x2")
        view.slider.maximumValueImage = .init(systemName: "squareshape.split.3x3")
    }
    
    func setupCollectionView(view: UICollectionView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.sliderView.bottomAnchor, constant: 10).isActive = true
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

class UISliderView: UIView {
    var valueChanged: CurrentValueSubject<Int, Never> = .init(1)
    
    let slider: UISlider = .init()
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension UISliderView {
    @objc func action(sender: UISlider) {
        self.valueChanged.send(Int(slider.value))
    }
}

private extension UISliderView {
    func setup() {
        self.setupSlider(slider: self.slider)
    }
    
    func setupSlider(slider: UISlider) {
        self.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        slider.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        slider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        slider.value = 1
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(self.action(sender:)), for: .valueChanged)
    }
}
