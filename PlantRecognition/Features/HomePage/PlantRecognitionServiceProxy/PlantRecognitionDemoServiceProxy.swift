//
//  PlantRecognitionDemoServiceProxy.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 26.05.2021.
//

import Foundation
import UIKit

final class PlantRecognitionDemoServiceProxy: PlantRecognitionServiceProxyProtocol {
    func recognize(image: UIImage, completion: (Result<PlantRecognitionServiceProxyResult, Error>) -> Void) {
        completion(.success(.init(scientificName: "morale tg")))
    }
}
