//
//  TipView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 27.06.2021.
//

import Foundation
import UIKit

final class TipView: UIView {
    private let appearance = Appearance()
    private lazy var bgBlurView: UIView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        return blurEffectView
    }()
    private lazy var titleLabel: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        titleLabel.set(text: model.title, with: appearance.titleStyle)
    }
}

// MARK: - Private methods
private extension TipView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(
            bgBlurView,
            titleLabel
        )
    }
    
    func setupConstraints() {
        bgBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        layer.cornerRadius = appearance.radius
        layer.masksToBounds = true
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Model
extension TipView {
    struct Model {
        let title: String
    }
}

// MARK: - Appearance
private extension TipView {
    struct Appearance {
        let titleStyle: TextStyle = .text16R
        let titleInsets: UIEdgeInsets = .init(top: 14, left: 21, bottom: 14, right: 21)
        let radius: CGFloat = 16
    }
}

