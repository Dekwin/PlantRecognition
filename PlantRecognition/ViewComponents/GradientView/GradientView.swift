//
//  GradientView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 23.06.2021.
//

import Foundation
import UIKit

/**
 * View with a gradient layer.
 */
class GradientView: UIView {

    let gradient : CAGradientLayer

    init(gradient: CAGradientLayer) {
        self.gradient = gradient
        super.init(frame: .zero)
        self.gradient.frame = self.bounds
        self.layer.insertSublayer(self.gradient, at: 0)
    }

    convenience init(colors: [UIColor], locations:[Float]? = nil) {
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        if let locations = locations {
            gradient.locations = locations.map { NSNumber(value: $0) }
        }
        self.init(gradient: gradient)
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.gradient.frame = self.bounds
    }

    required init?(coder: NSCoder) { fatalError("no init(coder:)") }
}
