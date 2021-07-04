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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        
    }
}

// MARK: - Private methods
private extension CapturePlantPhotoRetryView {
    func commonInit() {
        backgroundColor = appearance.bgColor
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
}

// MARK: - Model
extension CapturePlantPhotoRetryView {
    struct Model {
        
    }
}

// MARK: - Appearance
private extension CapturePlantPhotoRetryView {
    struct Appearance {
        let bgColor: UIColor = Asset.Colors.mainGreen.color.withAlphaComponent(0.2)
    }
}

