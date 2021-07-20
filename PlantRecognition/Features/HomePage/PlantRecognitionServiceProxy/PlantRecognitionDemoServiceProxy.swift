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
        completion(
            .success(
                .init(
                    resultType: .recognized(plantIdentity: .init(id: "1", thumb: .image(Asset.Images.DemoImages.cactus1.image), name: "Morale1", description: "Morale1 gh hjjgjhghjgjhjghghjgh gjh gj jghjgh"), probability: 0.9)
                )
            )
        )
    }
}
