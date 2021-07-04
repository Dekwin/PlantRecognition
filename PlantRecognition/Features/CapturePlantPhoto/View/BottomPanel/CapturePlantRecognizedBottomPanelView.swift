//
//  CapturePlantRecognizedBottomPanelView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 04.07.2021.
//

import Foundation
import UIKit

final class CapturePlantRecognizedBottomPanelView: UIView {
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
private extension CapturePlantRecognizedBottomPanelView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
}

// MARK: - Model
extension CapturePlantRecognizedBottomPanelView {
    struct Model {
        let image: UIImage
        let title: String
        let subtitle: String
        let nextButtonAction: Action
    }
}

// MARK: - Appearance
private extension CapturePlantRecognizedBottomPanelView {
    struct Appearance {
        
    }
}

