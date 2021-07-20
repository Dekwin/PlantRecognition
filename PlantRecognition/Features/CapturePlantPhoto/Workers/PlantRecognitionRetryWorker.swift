//
//  PlantRecognitionRetryWorker.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 17.07.2021.
//

import Foundation
import UIKit

protocol PlantRecognitionRetryWorkerProtocol: AnyObject {
    var recognitionRetriesLeft: Int { get }
    var hasRecognizePlantRetryAttempts: Bool { get }
    
    func recognize(
        sourceImage: UIImage,
        completion: @escaping (Result<PlantRecognitionRetryWorkerResult, Error>) -> Void
    )
}

struct PlantRecognitionRetryWorkerResult {
    let recognitionRetriesLeft: Int
    let canRetryAgain: Bool
    let recognitionResult: PlantRecognitionServiceProxyResult
}

class PlantRecognitionRetryWorker {
    private let plantRecognitionServiceProxy: PlantRecognitionServiceProxyProtocol
    private let maxRetries = 3
    private var currentRetriesCount = 0
    
    init(plantRecognitionServiceProxy: PlantRecognitionServiceProxyProtocol) {
        self.plantRecognitionServiceProxy = plantRecognitionServiceProxy
    }
}

extension PlantRecognitionRetryWorker: PlantRecognitionRetryWorkerProtocol {
    var hasRecognizePlantRetryAttempts: Bool {
        recognitionRetriesLeft > 0
    }
    
    var recognitionRetriesLeft: Int {
        maxRetries - currentRetriesCount
    }
    
    func recognize(sourceImage: UIImage, completion: @escaping (Result<PlantRecognitionRetryWorkerResult, Error>) -> Void) {
        guard hasRecognizePlantRetryAttempts else {
            completion(.failure(RetryError.noRetriesLeft))
            return
        }
        
        currentRetriesCount += 1
        
        plantRecognitionServiceProxy.recognize(image: sourceImage) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let result):
                switch result.resultType {
                case .notRecognizedError:
                    completion(.success(
                                .init(recognitionRetriesLeft: self.recognitionRetriesLeft, canRetryAgain: self.hasRecognizePlantRetryAttempts, recognitionResult: .init(resultType: .notRecognizedError)))
                    )
                case .recognized(let plantIdentity, let probability):
                    completion(
                        .success(
                            .init(recognitionRetriesLeft: self.recognitionRetriesLeft, canRetryAgain: self.hasRecognizePlantRetryAttempts, recognitionResult: .init(resultType: .recognized(plantIdentity: plantIdentity, probability: probability)))
                        )
                    )
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension PlantRecognitionRetryWorker {
    enum RetryError: Error {
        case noRetriesLeft
    }
}

private extension PlantIdentityInfo {
    func createCopy(withNewThumb thumb: ImageType) -> PlantIdentityInfo {
        .init(id: id, thumb: thumb, name: name, description: description)
    }
}
