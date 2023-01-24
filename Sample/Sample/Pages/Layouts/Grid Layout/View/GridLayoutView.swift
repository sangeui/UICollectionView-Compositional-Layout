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
    
    private let sliderView: UISliderView = .init()
    private let interGroupSliderView: UISliderView = .init()
    private let interItemSliderView: UISliderView = .init()
    
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
    }
    
    func observeSliderValueChanged(publisher: AnyPublisher<Int, Never>) {
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
        self.setupStackView(view: self.stackView)
        self.setupSliderView(view: self.sliderView)
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
        
        view.slider.value = .zero
        view.slider.minimumValue = .zero
        view.slider.maximumValue = 10
        view.slider.minimumValueImage = .init(systemName: "circlebadge.fill")
        view.primaryText = "INTER GROUP SPACING"
    }
    
    func setupInterItemSpacingSliderView(view: UISliderView) {
        self.stackView.addArrangedSubview(view)
        
        view.slider.value = .zero
        view.slider.minimumValue = .zero
        view.slider.maximumValue = 10
        view.slider.minimumValueImage = .init(systemName: "circlebadge.fill")
        view.primaryText = "INTER ITEM SPACING"
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

class UISliderView: UIView {
    var valueChanged: CurrentValueSubject<Int, Never> = .init(1)
    
    var primaryText: String {
        get { return self.primaryTextLabel.text ?? .init() }
        set { self.primaryTextLabel.text = newValue }
    }
    
    var secondaryText: String {
        get { return self.secondaryTextLabel.text ?? .init() }
        set { self.secondaryTextLabel.text = newValue }
    }
    
    let slider: UISlider = .init()
    
    private let primaryTextLabel: UILabel = .init()
    private let secondaryTextLabel: UILabel = .init()
    
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
        self.valueChanged.send(Int(sender.value))
        self.secondaryTextLabel.text = "\(Int(sender.value))"
    }
}

private extension UISliderView {
    func setup() {
        self.setupPrimaryTextLabel(label: self.primaryTextLabel)
        self.setupSecondaryTextLabel(label: self.secondaryTextLabel)
        self.setupSlider(slider: self.slider)
    }
    
    func setupPrimaryTextLabel(label: UILabel) {
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 11, weight: .semibold)
    }
    
    func setupSecondaryTextLabel(label: UILabel) {
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.primaryTextLabel.trailingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        label.centerYAnchor.constraint(equalTo: self.primaryTextLabel.centerYAnchor).isActive = true
        
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    func setupSlider(slider: UISlider) {
        self.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        slider.topAnchor.constraint(equalTo: self.primaryTextLabel.bottomAnchor, constant: 10).isActive = true
        slider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        slider.value = 1
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(self.action(sender:)), for: .valueChanged)
    }
}
