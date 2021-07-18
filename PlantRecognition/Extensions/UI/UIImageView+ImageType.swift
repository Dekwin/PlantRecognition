//
//  UIImageView+ImageType.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 18.07.2021.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    func setImage(withType imageType: ImageType?) {
        guard let imageType = imageType else {
            image = nil
            return
        }
        
        switch imageType {
        case .image(let img):
            image = img
        case .url(let imageUrl):
            af.setImage(withURL: imageUrl)
        }
    }
}
