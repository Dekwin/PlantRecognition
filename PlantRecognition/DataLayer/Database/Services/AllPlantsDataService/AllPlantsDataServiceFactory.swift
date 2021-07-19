//
//  AllPlantsDataServiceFactory.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 19.07.2021.
//

import Foundation

class AllPlantsDataServiceFactory {
    func create(isDemo: Bool) -> AllPlantsDataServiceProtocol {
        return isDemo
            ? AllPlantsDataDemoService()
            : AllPlantsDataDemoService()
    }
}
