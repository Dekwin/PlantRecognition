//
//  CapturePlantBottomPanelView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 30.06.2021.
//

import Foundation
import UIKit

final class CapturePlantBottomPanelView: UIView {
    private let appearance = Appearance()
    private let circleShapeLayer: CAShapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        circleShapeLayer.frame = self.bounds
        setupDrawing()
    }
}

// MARK: - Private methods
private extension CapturePlantBottomPanelView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        clipsToBounds = true
        layer.addSublayer(circleShapeLayer)
    }
    
    func setupConstraints() {
        
    }
}

// MARK: - Model
extension CapturePlantBottomPanelView {
    struct Model {
        
    }
}

// MARK: - Appearance
private extension CapturePlantBottomPanelView {
    struct Appearance {
        
    }
}

// MARK: - Drawing
private extension CapturePlantBottomPanelView {
    
    func setupDrawing() {
        circleShapeLayer.fillColor = UIColor.white.cgColor
        circleShapeLayer.path = createBezierPath().cgPath
    }
    
    func createBezierPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        let size = layer.bounds.size
        
        path.move(to: .init(x: 0, y: 0))
        path.addLine(to: .init(x: 0, y: size.height))
        path.addLine(to: .init(x: size.width, y: size.height))
        path.addLine(to: .init(x: size.width, y: 0))
        
        let radiusWidthMultiplier: CGFloat = 2
        
        let radius = radiusWidthMultiplier * size.width
        let x = layer.bounds.midX
        let y = radius
        path.addArc(withCenter: .init(x: x, y: y), radius: radius, startAngle: 0, endAngle: -.pi, clockwise: false)
        
        return path
    }
}
