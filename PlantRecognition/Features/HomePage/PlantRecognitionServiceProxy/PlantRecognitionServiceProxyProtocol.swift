//
//  PlantRecognitionServiceProxy.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 26.05.2021.
//

import Foundation
import Combine
import UIKit

struct PlantRecognitionServiceProxyResult {
    let scientificName: String?
}

protocol PlantRecognitionServiceProxyProtocol: AnyObject {
    func recognize(image: UIImage) -> Future<PlantRecognitionServiceProxyResult, Error>
}
