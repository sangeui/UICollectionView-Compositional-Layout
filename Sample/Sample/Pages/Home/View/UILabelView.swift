//
//  UILabelView.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import UIKit

class UILabelView: UIView {
    let label: UILabelViewLabel = .init()
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension UILabelView {
    func setup() {
        self.setupLabel(label: self.label)
    }
    
    func setupLabel(label: UILabel) {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

class UILabelViewLabel: UILabel {
    private var insets: UIEdgeInsets? = nil
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets ?? .zero))
    }
    
    override var intrinsicContentSize: CGSize {
        let superIntrinsicContentSize = super.intrinsicContentSize
        
        return .init(width: superIntrinsicContentSize.width + ((insets?.left ?? .zero) + (insets?.right ?? .zero)),
                     height: superIntrinsicContentSize.height + ((insets?.top ?? .zero) + (insets?.bottom ?? .zero)))
    }
    
    func updateInsets(_ insets: UIEdgeInsets) {
        self.insets = insets
    }
}
