//
//  PlantsDataService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.06.2021.
//

import Foundation

protocol MyPlantsDataServiceProtocol: AnyObject {
    func getAllMyPlants(callback: @escaping (Result<[PlantDetailsUserInfo], Error>) -> Void)
    func saveMyPlant(_ plant: PlantDetailsUserInfo, callback: @escaping (Result<PlantDetailsUserInfo, Error>) -> Void)
    func removeMyPlant(byId: String, callback: @escaping (Result<Void, Error>) -> Void)
}
