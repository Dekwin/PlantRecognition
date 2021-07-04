//
//  PlantsDataDemoService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.06.2021.
//

import Foundation
import UIKit

class PlantsDataDemoService: PlantsDataServiceProtocol {
    func getAllMyPlants(callback: @escaping (Result<[PlantDetailsUserInfo], Error>) -> Void) {
        let demoPlants: [PlantDetailsUserInfo] = [
            .init(plantIdentity: .init(id: "1", image: Asset.Images.DemoImages.demoPlant.image, name: "Nephrolepis", description: "Plant"), notifications: [.init(type: .fertilize)]),
            .init(plantIdentity: .init(id: "2", image: Asset.Images.DemoImages.demoPlant.image, name: "Peperomia blunt-leaved", description: "Sansevieria is a genus of stemless evergreen perennial herbaceous plants of the Asparagaceae family."), notifications: [.init(type: .repot), .init(type: .water)]),
            .init(plantIdentity: .init(id: "3", image: Asset.Images.DemoImages.demoPlant.image, name: "Sansevieria", description: "Sansevieria is a genus of stemless evergreen perennial herbaceous plants of the Asparagaceae family."), notifications: []),
        ]
        
        callback(.success(demoPlants))
    }
}
