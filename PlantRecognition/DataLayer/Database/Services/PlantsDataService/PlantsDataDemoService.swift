//
//  PlantsDataDemoService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.06.2021.
//

import Foundation
import UIKit

class PlantsDataDemoService: PlantsDataServiceProtocol {
    func getAllMyPlants(callback: @escaping (Result<[PlantDetailsInfo], Error>) -> Void) {
        let demoPlants: [PlantDetailsInfo] = [
            .init(id: "1", image: Asset.Images.DemoImages.demoPlant.image, name: "Nephrolepis", notifications: [.init(type: .fertilize)]),
            .init(id: "2", image: Asset.Images.DemoImages.demoPlant.image, name: "Peperomia blunt-leaved", notifications: [.init(type: .repot), .init(type: .water)]),
            .init(id: "3", image: Asset.Images.DemoImages.demoPlant.image, name: "Sansevieria", notifications: []),
        ]
        
        callback(.success(demoPlants))
    }
}
