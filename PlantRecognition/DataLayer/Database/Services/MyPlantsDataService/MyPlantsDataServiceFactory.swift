//
//  PlantsDataServiceFactory.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.06.2021.
//

import Foundation

class MyPlantsDataServiceFactory {
    func create(isDemo: Bool) -> MyPlantsDataServiceProtocol {
        return isDemo
            ? MyPlantsDataDemoService()
            : MyPlantsDataDemoService()
    }
}
