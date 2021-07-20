//
//  AllPlantsDataDemoService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 19.07.2021.
//

import Foundation

class AllPlantsDataDemoService {
    
}

extension AllPlantsDataDemoService: AllPlantsDataServiceProtocol {
    func getPlant(byId id: String, completion: @escaping (Result<PlantIdentityInfo?, Error>) -> Void) {
        completion(.success(DemoData.plant))
    }
    
    func getPlant(byBotanicalName botanicalName: String, completion: @escaping (Result<PlantIdentityInfo?, Error>) -> Void) {
        completion(.success(DemoData.plant))
    }
}

private extension AllPlantsDataDemoService {
    enum DemoData {
        static let plant = PlantIdentityInfo(
            id: "1",
            thumb: .image(Asset.Images.DemoImages.cactus1.image),
            name: "cactus"
        )
    }
}
