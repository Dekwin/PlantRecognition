//
//  UILabel+StyledText.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 20.06.2021.
//

import Foundation
import UIKit

extension UILabel {
    func set(text: String, with style: TextStyle) {
        attributedText = style.createAttributedText(from: text)
    }
}
