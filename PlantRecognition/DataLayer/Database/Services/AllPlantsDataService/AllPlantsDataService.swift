//
//  AllPlantsDataService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 19.07.2021.
//

import Foundation

protocol AllPlantsDataServiceProtocol: AnyObject {
    func getPlant(byId id: String, completion: @escaping (Result<PlantIdentityInfo?, Error>) -> Void)
    func getPlant(byBotanicalName botanicalName: String, completion: @escaping (Result<PlantIdentityInfo?, Error>) -> Void)
    /// Searches by botanical name and name
    func findPlant(matchingName name: String, completion: @escaping (Result<PlantIdentityInfo?, Error>) -> Void)
}
