//
//  CapturePlantPhotoScanningView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 04.07.2021.
//

import Foundation
import UIKit

final class CapturePlantPhotoScanningView: UIView {
    private let appearance = Appearance()
    private var state: State = .stopScanning
    private let animationKeyPath: String = "bounds"
    
    private lazy var scannerLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [appearance.topScannerGradientColor.cgColor, appearance.bottomScannerGradientColor.cgColor]
        layer.opacity = appearance.scannerOpacity
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        updateScanner(with: state)
    }
    
    func update(with model: Model) {
        state = model.state
        updateScanner(with: state)
    }
}

// MARK: - Private methods
private extension CapturePlantPhotoScanningView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        layer.cornerRadius = appearance.cornerRadius
        clipsToBounds = true
        
        layer.insertSublayer(scannerLayer, at: 0)
        
        scannerLayer.anchorPoint = .init(x: 0, y: 0)
        
        // Mirror vertically
        layer.transform = CATransform3DMakeScale(1, -1, 1)
    }
    
    func setupConstraints() {
        
    }
    
    func updateScanner(with state: State) {
        scannerLayer.frame = bounds
        switch state {
        case .startScanning:
            addAnimation(to: scannerLayer)
        case .stopScanning:
            scannerLayer.removeAnimation(forKey: animationKeyPath)
        }
    }
    
    func addAnimation(to layer: CALayer) {
        // Prepare the animation from the old size to the new size
        let oldBounds = CGRect(x: 0, y: 0, width: layer.bounds.width, height: 0)
        let newBounds = layer.bounds
        
        let animation = CABasicAnimation(keyPath: animationKeyPath)
        animation.fromValue = NSValue(cgRect: oldBounds)
        animation.toValue = NSValue(cgRect: newBounds)
        
        animation.duration = appearance.animationDuration
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = true
        animation.autoreverses = true
        
        // Add the animation, overriding the implicit animation.
        layer.add(animation, forKey: animationKeyPath)
    }
}

// MARK: - Model
extension CapturePlantPhotoScanningView {
    struct Model {
        let state: State
    }
    
    enum State {
        case startScanning
        case stopScanning
    }
}

// MARK: - Appearance
private extension CapturePlantPhotoScanningView {
    struct Appearance {
        let cornerRadius: CGFloat = 28
        let animationDuration: CFTimeInterval = 5
        let scannerOpacity: Float = 0.4
        let topScannerGradientColor: UIColor = Asset.Colors.additionalGreen.color.withAlphaComponent(0)
        let bottomScannerGradientColor: UIColor = Asset.Colors.additionalGreen.color
    }
}

