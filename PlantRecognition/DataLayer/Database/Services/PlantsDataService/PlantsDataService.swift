//
//  PlantsDataService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.06.2021.
//

import Foundation

protocol PlantsDataServiceProtocol: AnyObject {
    func getAllMyPlants(callback: @escaping (Result<[PlantDetailsInfo], Error>) -> Void)
}
