//
//  PlantsDataDemoService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.06.2021.
//

import Foundation
import UIKit

class MyPlantsDataDemoService: MyPlantsDataServiceProtocol {
    func saveMyPlant(_ plant: PlantDetailsUserInfo, callback: @escaping (Result<PlantDetailsUserInfo, Error>) -> Void) {
        callback(.success(plant))
    }
    
    func removeMyPlant(byId: String, callback: @escaping (Result<Void, Error>) -> Void) {
        callback(.success(()))
    }
    
    func getAllMyPlants(callback: @escaping (Result<[PlantDetailsUserInfo], Error>) -> Void) {
        let demoPlants: [PlantDetailsUserInfo] = [
            .init(id: "1", plantIdentity: .init(id: "1", thumb: .url(imageUrl: URL(string: "http://novadosoft.com/plant-recognition-2021/data/resources/R2V0dHlJbW-GettyImages-1142656507-49f5b21d3e294b939fc0d9c1c0aa72b1.jpg")!, placeholderImage: Asset.Images.Components.plantPlaceholderImage.image), name: "Nephrolepis", description: "Plant"), notifications: [.init(type: .fertilize)]),
            .init(id: "1", plantIdentity: .init(id: "2", thumb: .image(Asset.Images.DemoImages.demoPlant.image), name: "Peperomia blunt-leaved", description: "Sansevieria is a genus of stemless evergreen perennial herbaceous plants of the Asparagaceae family."), notifications: [.init(type: .repot), .init(type: .water)]),
            .init(id: "1", plantIdentity: .init(id: "3", thumb: .image(Asset.Images.DemoImages.demoPlant.image), name: "Sansevieria", description: "Sansevieria is a genus of stemless evergreen perennial herbaceous plants of the Asparagaceae family."), notifications: []),
        ]
        
        callback(.success(demoPlants))
    }
}
