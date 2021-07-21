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
    private let deps: Deps
    
    init(deps: Deps) {
        self.deps = deps
    }
}

extension PlantIdPlantRecognitionServiceProxy: PlantRecognitionServiceProxyProtocol {
    func recognize(
        image: UIImage,
        completion: @escaping (Result<PlantRecognitionServiceProxyResult, Error>) -> Void
    ){
        recognizePlantAndGetSuggestion(plantImage: image) { [weak self] result in
            switch result {
            case .success(let foundSuggestion):
                guard let foundSuggestion = foundSuggestion else {
                    completion(.success(.init(resultType: .notRecognizedError)))
                    return
                }
                
                let botanicalName = foundSuggestion.plantName
                
                self?.deps.allPlantsDataService.findPlant(
                    matchingName: botanicalName,
                    completion: { result in
                        guard let self = self else { return }
                        
                        switch result {
                        case .success(let plantIdentity):
                            // Found in DB
                            if let plantIdentity = plantIdentity {
                                completion(
                                    .success(
                                        .init(resultType: .recognized(
                                            plantIdentity: plantIdentity,
                                            probability: foundSuggestion.probability
                                        ))
                                    )
                                )
                            } else {
                                // Not found in DB
                                let identity = self.buildPlantIdentity(from: foundSuggestion, plantOriginalPhoto: image)
                                completion(
                                    .success(
                                        .init(resultType: .recognized(
                                            plantIdentity: identity,
                                            probability: foundSuggestion.probability
                                        ))
                                    )
                                )
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Recogrizing image

private extension PlantIdPlantRecognitionServiceProxy {
    
    func buildPlantIdentity(from suggestion: PlantIdSuggestion, plantOriginalPhoto: UIImage) -> PlantIdentityInfo {
        let thumb: ImageType?
        if let thumbUrl = suggestion.plantDetails?.wikiImage?.value {
            thumb = .url(imageUrl: thumbUrl, placeholderImage: Asset.Images.Components.plantPlaceholderImage.image)
        } else {
            thumb = .image(plantOriginalPhoto)
        }
        
        return .init(
            id: "1",
            thumb: thumb,
            name: suggestion.plantName,
            description: suggestion.plantDetails?.commonNames?.joined(separator: ", ") ?? ""
        )
    }
    
    func recognizePlantAndGetSuggestion(
        plantImage image: UIImage,
        completion: @escaping (Result<PlantIdSuggestion?, Error>) -> Void
    ){
        let preparedImage = prepareImageForUploading(image)
        
        deps.plantIdService.identify(
            request: .init(
                imagesBase64: [preparedImage].compactMap { $0.toBase64String() },
                plantDetails: ["common_names", "url", "probability", "wiki_image"]
            ),
            completion: { result in
                switch result {
                case .success(let suggestions):
                    let minProbability: Double = 0.3 // 30%
                    let foundSuggestion = suggestions
                        .suggestions
                        .first { suggestion in
                            let probability = suggestion.probability ?? 0
                            return probability >= minProbability
                        }
                    
                    completion(.success(foundSuggestion))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    func prepareImageForUploading(_ image: UIImage) -> UIImage {
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

extension PlantIdPlantRecognitionServiceProxy {
    struct Deps {
        let allPlantsDataService: AllPlantsDataServiceProtocol
        let plantIdService: PlantIdServiceProtocol
    }
}
