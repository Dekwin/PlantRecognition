//
//  CapturePlantNotRecognizedBottomPanelView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 17.07.2021.
//

import Foundation
import UIKit

final class CapturePlantNotRecognizedBottomPanelView: UIView {
    private let appearance = Appearance()
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = appearance.bgColor
        return view
    }()
    
    private lazy var plantImageView = UIImageView()
    
    private lazy var titleSubtitleStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                titleLabel,
                subtitleLabel,
                UIView()
            ]
        )
        stack.axis = .vertical
        stack.spacing = appearance.titleSubtitleSpacing
        return stack
    }()
    private lazy var titleLabel = UILabel()
    private lazy var subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.roundCorners(corners: [.topLeft, .topRight], radius: appearance.cornerRadius)
    }
    
    func update(with model: Model) {
        plantImageView.image = model.image
        titleLabel.set(text: model.title, with: appearance.titleTextStyle)
        subtitleLabel.set(text: model.subtitle, with: appearance.subtitleTextStyle)
    }
}

// MARK: - Private methods
private extension CapturePlantNotRecognizedBottomPanelView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(
            bgView
        )
        
        bgView.addSubviews(
            plantImageView,
            titleSubtitleStackView
        )
        
        plantImageView.contentMode = .scaleAspectFill
        plantImageView.clipsToBounds = true
        plantImageView.layer.cornerRadius = appearance.imageCornerRadius
        
        titleLabel.numberOfLines = 2
        subtitleLabel.numberOfLines = 0
    }
    
    func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
        }
        
        plantImageView.snp.makeConstraints { make in
            make.width.equalTo(appearance.plantImageWidth)
            make.top.bottom.left.equalToSuperview().inset(appearance.contentInsets)
            make.right.equalTo(titleSubtitleStackView.snp.left).inset(-appearance.imageAndTextSpacing)
        }
        
        titleSubtitleStackView.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview().inset(appearance.contentInsets)
        }
        
    }
}

// MARK: - Model
extension CapturePlantNotRecognizedBottomPanelView {
    struct Model {
        let image: UIImage?
        let title: String
        let subtitle: String
    }
}

// MARK: - Appearance
private extension CapturePlantNotRecognizedBottomPanelView {
    struct Appearance {
        let cornerRadius: CGFloat = 20
        let imageCornerRadius: CGFloat = 12
        let bgColor: UIColor = Asset.Colors.white.color
        let nextButtonRightInset: CGFloat = .gapXL
        let nextButtonSize: CGSize = .init(width: 60, height: 60)
        let contentInsets: UIEdgeInsets = .init(top: .gapL, left: .gapXL, bottom: .gapL, right: .gapM)
        let imageAndTextSpacing: CGFloat = .gapM
        let titleSubtitleSpacing: CGFloat = .gapS
        let plantImageWidth: CGFloat = 69.0
        
        let titleTextStyle: TextStyle = .subtitle18M.set(color: .defined(value: Asset.Colors.mainGreen.color))
        let subtitleTextStyle: TextStyle = .text14R
    }
}

