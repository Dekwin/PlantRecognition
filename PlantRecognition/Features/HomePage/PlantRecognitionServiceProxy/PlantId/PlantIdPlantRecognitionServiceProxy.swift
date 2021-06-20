//
//  PlantIdPlantRecognitionServiceProxy.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation
import UIKit
import Combine

class PlantIdPlantRecognitionServiceProxy {
    private let plantIdService: PlantIdServiceProtocol
    
    init(plantIdService: PlantIdServiceProtocol) {
        self.plantIdService = plantIdService
    }
}

extension PlantIdPlantRecognitionServiceProxy: PlantRecognitionServiceProxyProtocol {
    func recognize(
        image: UIImage,
        completion: @escaping (Result<PlantRecognitionServiceProxyResult, Error>) -> Void
    ){
        let preparedImage = prepareImageForUploading(image)
        
        plantIdService.identify(
            request: .init(
                imagesBase64: [preparedImage].compactMap { $0.toBase64String() },
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
    
    private func prepareImageForUploading(_ image: UIImage) -> UIImage {
        guard
            let size = image.getSizeIn(.megabyte),
            size > 2.0
        else {
            return image
        }
        
        let resizedImage = image.resized(toWidth: 1024) ?? image
                
        return resizedImage
    }
}
