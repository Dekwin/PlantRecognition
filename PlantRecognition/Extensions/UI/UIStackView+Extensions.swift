//
//  UIStackView+Extensions.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 30.05.2021.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach(addArrangedSubview)
    }
    
    func removeArrangedSubviews() {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    /// Удаляет из стэка старые view и добавляет новые
    func replaceArrangedSubviews(_ views: [UIView]) {
        removeArrangedSubviews()
        addArrangedSubviews(views)
    }
}
