//
//  InfoCardView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 22.06.2021.
//

import Foundation
import UIKit

final class InfoCardView: UIView {
    private let appearance = Appearance()
    private lazy var bgImageView: UIImageView = .init(image: Asset.Images.Components.Cards.cardBg.image)
    private lazy var leftImageView: UIImageView = .init(image: nil)
    private lazy var titleLabel: UILabel = .init()
    private var tapAction: Action?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        leftImageView.image = model.image
        
        switch model.title {
        case .default(let text):
            titleLabel.set(text: text, with: appearance.titleStyle)
        case .attributed(let attributed):
            titleLabel.attributedText = attributed
        }
        
        tapAction = model.tapAction
    }
}

// MARK: - Private methods
private extension InfoCardView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        addTapGesture()
    }
    
    func setupSubviews() {
        addSubviews(
            bgImageView,
            leftImageView,
            titleLabel
        )
        
        titleLabel.numberOfLines = appearance.titleNumberOfLines
        
        layer.cornerRadius = appearance.radius
        layer.masksToBounds = true
        
        leftImageView.layer.cornerRadius = appearance.radius
        leftImageView.layer.masksToBounds = true
        
        leftImageView.contentMode = .scaleAspectFill
    }
    
    func setupConstraints() {
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        leftImageView.snp.makeConstraints { make in
            make.left.bottom.top.equalToSuperview()
            make.size.equalTo(appearance.imageSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).inset(-appearance.titleImageSpacing)
            make.trailing.equalToSuperview().inset(appearance.titleTrailingInset)
            make.centerY.equalToSuperview()
        }
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        addGestureRecognizer(tap)
    }
    
    @objc
    func cardTapped() {
        tapAction?()
    }
}

// MARK: - Model
extension InfoCardView {
    struct Model {
        let image: UIImage
        let title: TextValue
        let tapAction: Action
    }
    
    enum TextValue: Equatable {
        case `default`(String)
        case attributed(NSAttributedString)
    }
}

// MARK: - Appearance
private extension InfoCardView {
    struct Appearance {
        let imageSize: CGSize = .init(width: 100.0, height: 100.0)
        let titleImageSpacing: CGFloat = .gapL
        let titleTrailingInset: CGFloat = .gapL
        let titleStyle: TextStyle = .subtitle18M
        let radius: CGFloat = 20
        let titleNumberOfLines: Int = 0
    }
}
