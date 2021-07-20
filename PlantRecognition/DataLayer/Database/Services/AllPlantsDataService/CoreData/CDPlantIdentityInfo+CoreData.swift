//
//  PlantIdentityInfo+CoreData.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 20.07.2021.
//

import Foundation
import CoreData

extension CDPlantIdentityInfo {
    func update(with plant: PlantIdentityInfo) {
        id = plant.id
        name = plant.name
        botanicalName = plant.botanicalName
    }
    
    func toDTO() -> PlantIdentityInfo? {
        guard let id = id, let name = name else { return nil }
        
        return .init(
            id: id,
            name: name,
            botanicalName: botanicalName
        )
    }
}
