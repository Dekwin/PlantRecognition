//
//  PlantIdPlantRecognitionServiceProxy.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation
import UIKit
import Combine

class PlantIdPlantRecognitionServiceProxy: PlantRecognitionServiceProxyProtocol {
    private let plantIdService: PlantIdServiceProtocol
    
    init(plantIdService: PlantIdServiceProtocol) {
        self.plantIdService = plantIdService
    }
    
    func recognize(image: UIImage) -> AnyPublisher<PlantRecognitionServiceProxyResult, Error> {
        
//       return Future { promise in
//            promise(.success(
//                PlantRecognitionServiceProxyResult(
//                    scientificName: "suggestions.suggestions.first?.plantName"
//                )
//            ))
//       }.eraseToAnyPublisher()
        
        plantIdService.identify(
            request: .init(
                images: [image],
                plantDetails: ["common_names", "url", "wiki_description", "taxonomy"]
            )
        )
        .map { suggestions in
            PlantRecognitionServiceProxyResult(
                scientificName: suggestions.suggestions.first?.plantName
            )
        }
        .eraseToAnyPublisher()
    }
}
