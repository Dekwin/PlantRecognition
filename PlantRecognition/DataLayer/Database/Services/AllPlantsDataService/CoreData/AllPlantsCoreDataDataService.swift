//
//  AllPlantsCoreDataDataService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 19.07.2021.
//

import Foundation

class AllPlantsCoreDataDataService {
    private let allPlantsJsonToCoreDataMapper: AllPlantsJsonToCoreDataMapperProtocol
    
    init(allPlantsJsonToCoreDataMapper: AllPlantsJsonToCoreDataMapperProtocol) {
        self.allPlantsJsonToCoreDataMapper = allPlantsJsonToCoreDataMapper
    }
    
    func initialize(completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
}

extension AllPlantsCoreDataDataService: AllPlantsDataServiceProtocol {
    func getPlant(byId id: String, completion: @escaping (Result<PlantIdentityInfo, Error>) -> Void) {
        <#code#>
    }
    
    func getPlant(byBotanicalName botanicalName: String, completion: @escaping (Result<PlantIdentityInfo, Error>) -> Void) {
        <#code#>
    }
}
