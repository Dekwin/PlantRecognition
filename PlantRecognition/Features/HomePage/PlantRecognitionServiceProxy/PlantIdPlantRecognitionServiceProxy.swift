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
    
    func recognize(
        image: UIImage,
        completion: @escaping (Result<PlantRecognitionServiceProxyResult, Error>) -> Void
    ){        
        plantIdService.identify(
            request: .init(
                images: [image],
                plantDetails: ["common_names", "url", "wiki_description", "taxonomy"]
            ),
            completion: { result in
                switch result {
                case .success(let suggestions):
                    completion(
                        .success( PlantRecognitionServiceProxyResult(scientificName: suggestions.suggestions.first?.plantName))
                    )
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
