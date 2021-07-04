//
//  SelectImageFromGalleryView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 03.07.2021.
//

import Foundation
import UIKit

final class SelectImageFromGalleryView: UIView {
    private let appearance = Appearance()
    private lazy var imageView: UIImageView = .init()
    private var action: Action?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        self.action = model.tapAction
        
        switch model.style {
        case .placeholder:
            imageView.image = appearance.placeholderImage
        case .image(let image):
            imageView.image = image
        }
    }
}

// MARK: - Private methods
private extension SelectImageFromGalleryView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tap)
        
        imageView.layer.cornerRadius = appearance.cornerRadius
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc
    func viewTapped() {
        action?()
    }
}

// MARK: - Model
extension SelectImageFromGalleryView {
    struct Model {
        let style: Style
        let tapAction: Action
    }
    
    enum Style {
        case placeholder
        case image(UIImage)
    }
}

// MARK: - Appearance
private extension SelectImageFromGalleryView {
    struct Appearance {
        let placeholderImage: UIImage = Asset.Images.Components.Buttons.SelectImageFromGallery.placeholderImage.image
        let cornerRadius: CGFloat = 12.0
    }
}

