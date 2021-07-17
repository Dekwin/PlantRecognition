//
//  CapturePlantPhotoRetryView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 04.07.2021.
//

import Foundation
import UIKit

final class CapturePlantPhotoRetryView: UIView {
    private let appearance = Appearance()
    private lazy var retryButton: UIButton = .init()
    private lazy var tipView: TipView = .init()
    private lazy var bgImageView: UIImageView = .init(image: nil)
    private lazy var bgTintView: UIView = {
        let view = UIView()
        view.backgroundColor = appearance.bgTintColor
        return view
    }()
    private var retryButtonAction: Action?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        retryButtonAction = model.retryButtonAction
        if let tip = model.tip {
            tipView.update(with: tip)
            tipView.isHidden = false
        } else {
            tipView.isHidden = true
        }
        
        bgImageView.image = model.bgImage
    }
}

// MARK: - Private methods
private extension CapturePlantPhotoRetryView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(
            bgImageView,
            bgTintView,
            retryButton,
            tipView
        )
        
        retryButton.setImage(Asset.Images.Components.Buttons.reloadButton.image, for: .normal)
        retryButton.addTarget(self, action: #selector(retryTouched), for: .touchUpInside)
        
        bgImageView.contentMode = .scaleAspectFill
    }
    
    func setupConstraints() {
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgTintView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        retryButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(appearance.retryButtonSize)
        }
        
        tipView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(retryButton.snp.bottom).inset(-appearance.buttonAndTipSpacing)
        }
    }
    
    @objc
    func retryTouched() {
        retryButtonAction?()
    }
}

// MARK: - Model
extension CapturePlantPhotoRetryView {
    struct Model {
        let bgImage: UIImage?
        let tip: TipView.Model?
        let retryButtonAction: Action
    }
}

// MARK: - Appearance
private extension CapturePlantPhotoRetryView {
    struct Appearance {
        let bgTintColor: UIColor = Asset.Colors.mainGreen.color.withAlphaComponent(0.2)
        let buttonAndTipSpacing: CGFloat = .gap2XL
        let retryButtonSize: CGSize = .init(width: 90, height: 90)
    }
}

