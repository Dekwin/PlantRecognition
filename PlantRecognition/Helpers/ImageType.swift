//
//  ImageType.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 18.07.2021.
//

import Foundation
import UIKit

enum ImageType {
    case image(UIImage)
    case url(imageUrl: URL, placeholderImage: UIImage?)
}
