//
//  PlantRecognitionResult.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 04.07.2021.
//

import Foundation
import UIKit

enum PlantRecognitionResult {
    case notRecognizedError
    case recognized(plantIdentity: PlantIdentityInfo)
}
