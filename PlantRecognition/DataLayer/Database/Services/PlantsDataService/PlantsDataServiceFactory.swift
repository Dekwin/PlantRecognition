//
//  PlantsDataServiceFactory.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.06.2021.
//

import Foundation

class PlantsDataServiceFactory {
    func create(isDemo: Bool) -> PlantsDataServiceProtocol {
        return isDemo
            ? PlantsDataDemoService()
            : PlantsDataDemoService()
    }
}
