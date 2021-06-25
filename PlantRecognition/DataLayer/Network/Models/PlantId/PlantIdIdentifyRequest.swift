//
//  PlantIdIdentifyRequest.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 26.05.2021.
//

import Foundation
import UIKit

struct PlantIdIdentifyRequest: Encodable {
    let imagesBase64: [String]
    let plantDetails: [String]
    
    private enum CodingKeys : String, CodingKey {
        case imagesBase64 = "images"
        case plantDetails = "plant_details"
    }
}
