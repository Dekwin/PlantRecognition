//
//  AllPlantsJsonParser.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 19.07.2021.
//

import Foundation
import CoreData

protocol AllPlantsJsonMapperProtocol: AnyObject {
    func createPlantsFromJson(completion: @escaping (Result<[PlantIdentityInfo], Error>) -> Void)
}

class AllPlantsJsonMapper {
    private let plantsListFileName = "plants_with_details_list_with_replaced_images_path"
}

extension AllPlantsJsonMapper: AllPlantsJsonMapperProtocol {
    func createPlantsFromJson(completion: @escaping (Result<[PlantIdentityInfo], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            let itemsResult = self.getPlantsFromJson()
            
            DispatchQueue.main.async {
                completion(itemsResult)
            }
        }
    }
}

private extension AllPlantsJsonMapper {
    func loadPlantsListJson() -> Any? {
        guard let path = Bundle.main.path(forResource: plantsListFileName, ofType: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            return jsonResult
        } catch {
            return nil
        }
    }
    
    func getPlantsFromJson() -> Result<[PlantIdentityInfo], Error> {
        guard
            let plantsListJson = loadPlantsListJson(),
            let plantDicts = plantsListJson as? [[String: Any]]
        else {
            return .failure(ParseError.canNotParseJsonData)
        }
        
        let plants = plantDicts.compactMap { mapPlantDictToObject(plantDict: $0) }
        
        return .success(plants)
    }
    
    func mapPlantDictToObject(plantDict: [String: Any]) -> PlantIdentityInfo? {
        guard
            let id = plantDict[PlantKeys.id] as? Int64,
            let name = plantDict[PlantKeys.name] as? String
        else {
            return nil
        }
        
        let plant = PlantIdentityInfo(
            id: String(id),
            name: name,
            botanicalName: plantDict[PlantKeys.botanicalName] as? String
        )
        
        return plant
    }
}

private extension AllPlantsJsonMapper {
    enum PlantKeys {
        static let id = "id"
        static let name = "name"
        static let botanicalName = "botanicalName"
    }
    
    enum ParseError: Error {
        case canNotParseJsonData
    }
}
