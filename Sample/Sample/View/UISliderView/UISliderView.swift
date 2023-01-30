//
//  UISliderView.swift
//  Sample
//
//  Created by William on 2023/01/26.
//

import Combine
import UIKit

class UISliderView<T: RawRepresentable>: UIView {
    let valueChanged: Subject
    let type: T
    
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
    
    private let configuration: ValueConfiguration
    
    init(configuration: ValueConfiguration, type: T) {
        self.configuration = configuration
        self.type = type
        self.valueChanged = .init((Int(configuration.default), self.type))
        
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func action(sender: UISlider) {
        self.valueChanged.send((Int(sender.value), self.type))
        self.secondaryTextLabel.text = "\(Int(sender.value))"
    }
}

extension UISliderView {
    typealias Publisher = AnyPublisher<(Int, T), Never>
    typealias Subject = CurrentValueSubject<(Int, T), Never>
    
    struct ValueConfiguration {
        let minimum: Float
        let maximum: Float
        let `default`: Float
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
        label.text = "\(Int(self.configuration.default))"
    }
    
    func setupSlider(slider: UISlider) {
        self.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        slider.topAnchor.constraint(equalTo: self.primaryTextLabel.bottomAnchor, constant: 10).isActive = true
        slider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        slider.value = self.configuration.default
        slider.minimumValue = self.configuration.minimum
        slider.maximumValue = self.configuration.maximum
        slider.addTarget(self, action: #selector(self.action(sender:)), for: .valueChanged)
    }
}

extension UISliderView {
    static func create(type: UISliderViewType) -> UISliderView<UISliderViewType> {
        let view: UISliderView<UISliderViewType>
        
        switch type {
        case .numberOfColumns:
            view = UISliderView<UISliderViewType>(configuration: .init(minimum: 1, maximum: 10, default: 1),
                                                                    type: type)
            view.primaryText = "NUMBER OF COLUMNS"
        case .interSectionSpacing:
            view = UISliderView<UISliderViewType>(configuration: .init(minimum: .zero, maximum: 10, default: .zero),
                                                                    type: type)
            view.primaryText = "INTER SECTION SPACING"
        case .interGroupSpacing:
            view = UISliderView<UISliderViewType>(configuration: .init(minimum: .zero, maximum: 10, default: .zero),
                                                                    type: type)
            view.primaryText = "INTER GROUP SPACING"
        case .interItemSpacing:
            view = UISliderView<UISliderViewType>(configuration: .init(minimum: .zero, maximum: 10, default: .zero),
                                                                    type: type)
            view.primaryText = "INTER ITEM SPACING"
        }
        
        view.slider.minimumValueImage = .init(systemName: "circlebadge.fill")
        
        return view
    }
}
