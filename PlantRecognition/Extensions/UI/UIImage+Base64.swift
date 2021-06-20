//
//  UIImage+Base64.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation
import UIKit

extension UIImage {
    func toBase64String () -> String? {
        return self.pngData()?.base64EncodedString()
    }
}
