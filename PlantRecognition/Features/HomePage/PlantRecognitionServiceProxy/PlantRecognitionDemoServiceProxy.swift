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
        completion(.success(
            .init(
                suggestions: [
                    .init(name: "Morale1 gh hjjgjhghjgjhjghghjgh gjh gj jghjgh", probability: 0.9),
                    .init(name: "Morale4", probability: 0.3)
                ]
            )
        ))
    }
}
