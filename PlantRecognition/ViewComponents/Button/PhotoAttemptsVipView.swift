//
//  PhotoAttemptsVipView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 03.07.2021.
//

import Foundation
import UIKit

final class PhotoAttemptsVipView: UIView {
    private let appearance = Appearance()
    private var tapAction: Action?
    
    private lazy var imageView: UIImageView = .init(image: Asset.Images.Iconly.password.image)
    private lazy var label: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        tapAction = model.tapAction
        
        switch model.style {
        case .fullAccess:
            label.set(text: L10n.PhotoAttemptsVip.fullAccess, with: appearance.labelStyle)
        case .division(let dividend, let divider):
            label.set(text: "\(dividend)/\(divider)", with: appearance.labelStyle)
        }
    }
}

// MARK: - Private methods
private extension PhotoAttemptsVipView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(
            imageView,
            label
        )
        
        backgroundColor = appearance.bgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tap)
        
        layer.cornerRadius = appearance.cornerRadius
        clipsToBounds = true
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(appearance.contentInsets.top)
            
            make.leading.greaterThanOrEqualToSuperview().inset(appearance.imageHorizontalInsets)
            make.trailing.lessThanOrEqualToSuperview().inset(appearance.imageHorizontalInsets)
            
            make.centerX.equalToSuperview()
            
            make.bottom.equalTo(label.snp.top).inset(-appearance.imageLabelSpacing)
            make.size.equalTo(appearance.imageSize)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(appearance.contentInsets.left)
            make.right.equalToSuperview().inset(appearance.contentInsets.right)
            make.bottom.equalToSuperview().inset(appearance.contentInsets.bottom)
        }
    }
    
    @objc
    func viewTapped() {
        tapAction?()
    }
}

// MARK: - Model
extension PhotoAttemptsVipView {
    struct Model {
        let tapAction: Action
        let style: Style
    }
    
    enum Style {
        case fullAccess
        case division(dividend: Int, divider: Int)
    }
}

// MARK: - Appearance
private extension PhotoAttemptsVipView {
    struct Appearance {
        let labelStyle: TextStyle = .text9M
        let bgColor: UIColor = Asset.Colors.additionalGreen.color
        let cornerRadius: CGFloat = 12.0
        let contentInsets: UIEdgeInsets = .init(top: .gapXS, left: .gapXS, bottom: .gapXS, right: .gapXS)
        let imageLabelSpacing: CGFloat = 3
        let imageSize: CGSize = .init(width: 20, height: 20)
        let imageHorizontalInsets: CGFloat = .gapL
    }
}

