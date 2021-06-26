//
//  SearchTabBgGradientView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 26.06.2021.
//

import Foundation
import UIKit

final class SearchTabBgGradientView: UIView {
    private let appearance = Appearance()
    private let shapeLayer: CAShapeLayer = CAShapeLayer()
    private let gradient: CAGradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        shapeLayer.frame = self.bounds
        gradient.frame = self.bounds
        gradient.mask = shapeLayer
        setupDrawing()
    }
}

// MARK: - Private methods
private extension SearchTabBgGradientView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        
        setupDrawing()
    }
    
    func setupSubviews() {
        layer.addSublayer(shapeLayer)
        layer.insertSublayer(gradient, at: 0)
        updateGradient()
    }
    
    func setupConstraints() {
        
    }
    
    func updateGradient() {
        let colors: [UIColor] = [
            Asset.Colors.greenLight.color.withAlphaComponent(0.44),
            Asset.Colors.greenLight.color,
        ]
        
        let locations = [0, 1]
        
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations.map { NSNumber(value: $0) }
    }
}

// MARK: - Drawing
private extension SearchTabBgGradientView {
    
    func setupDrawing() {
        
        // The Bezier path that we made needs to be converted to
        // a CGPath before it can be used on a layer.
        shapeLayer.path = createBezierPath().cgPath
        
        // apply other properties related to the path
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 1.0
    }
    
    func createBezierPath() -> UIBezierPath {
        // create a new path
        let path = UIBezierPath()
        
        let size = layer.bounds.size
        
        path.move(to: .init(x: 0, y: size.width))
        path.addLine(to: .init(x: 0, y: 0))
        path.addLine(to: .init(x: size.width, y: 0))
        path.addLine(to: .init(x: size.width, y: size.height))
        
        let radius = 1.28266666667 * size.width
        let x = layer.bounds.midX
        let y = size.height - radius
        path.addArc(withCenter: .init(x: x, y: y), radius: radius, startAngle: 0, endAngle: .pi, clockwise: true)
        
        return path
    }
}

// MARK: - Appearance
private extension SearchTabBgGradientView {
    struct Appearance {
        
    }
}

