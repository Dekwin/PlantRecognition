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
                imagesBase64: [image].compactMap { $0.toBase64String() },
                plantDetails: ["common_names", "url", "probability"]
            ),
            completion: { result in
                switch result {
                case .success(let suggestions):
                    let mappedSuggestions = suggestions
                        .suggestions
                        .map { PlantRecognitionServiceProxyResult.PlantSuggestion(name: $0.plantName, probability: $0.probability) }
                    
                    completion(
                        .success(
                            .init(suggestions: mappedSuggestions)
                        )
                    )
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
