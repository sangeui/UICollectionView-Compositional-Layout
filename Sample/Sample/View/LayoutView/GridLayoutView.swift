//
//  GridLayoutView.swift
//  Sample
//
//  Created by William on 2023/01/31.
//

import Combine
import UIKit

class GridLayoutView: LayoutView {
    private let numberOfColumnssliderView: UISliderView = .create(type: .numberOfColumns)
    private let interSectionSliderView: UISliderView = .create(type: .interSectionSpacing)
    private let interGroupSliderView: UISliderView = .create(type: .interGroupSpacing)
    private let interItemSliderView: UISliderView = .create(type: .interItemSpacing)
    
    init() {
        super.init(layout: GridCollectionViewCompositionalLayout())
        self.setup()
        self.observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension GridLayoutView {
    func observe() {
        self.observeSliderValueChanged(publisher: self.numberOfColumnssliderView.valueChanged.eraseToAnyPublisher())
        self.observeSliderValueChanged(publisher: self.interGroupSliderView.valueChanged.eraseToAnyPublisher())
        self.observeSliderValueChanged(publisher: self.interItemSliderView.valueChanged.eraseToAnyPublisher())
        self.observeSliderValueChanged(publisher: self.interSectionSliderView.valueChanged.eraseToAnyPublisher())
    }
}

private extension GridLayoutView {
    func setup() {
        self.stackView.addArrangedSubview(numberOfColumnssliderView)
        self.stackView.addArrangedSubview(interSectionSliderView)
        self.stackView.addArrangedSubview(interGroupSliderView)
        self.stackView.addArrangedSubview(interItemSliderView)
    }
}
