//
//  PlantRecognitionDemoServiceProxy.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 26.05.2021.
//

import Foundation
import Combine
import UIKit

final class PlantRecognitionDemoServiceProxy: PlantRecognitionServiceProxyProtocol {
    func recognize(image: UIImage) -> AnyPublisher<PlantRecognitionServiceProxyResult, Error> {
        return  Future() { promise in
            promise(.success(.init(scientificName: "morale tg")))
        }
        .eraseToAnyPublisher()
    }
}
