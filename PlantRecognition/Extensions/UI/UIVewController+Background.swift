//
//  UIVewController+Background.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 23.06.2021.
//

import Foundation
import UIKit
import SnapKit

extension UIViewController {
    func setupDefaultBackgroundView() {
        let colors: [UIColor] = [
            Asset.Colors.BgGradient.bgGradient1.color,
            Asset.Colors.BgGradient.bgGradient2.color,
            Asset.Colors.BgGradient.bgGradient3.color,
        ]
        
        let gradientView = GradientView(
            colors: colors,
            locations: [0, 0.0001, 1]
        )
        
        view.insertSubview(gradientView, at: 0)
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
