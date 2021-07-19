//
//  AllPlantsJsonParser.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 19.07.2021.
//

import Foundation
import CoreData

protocol AllPlantsJsonToCoreDataMapperProtocol: AnyObject {
    func createPlantsFromJson(completion: @escaping (Result<Void, Error>) -> Void)
}

class AllPlantsJsonToCoreDataMapper {
    
}

extension AllPlantsJsonToCoreDataMapper: AllPlantsJsonToCoreDataMapperProtocol {
    func createPlantsFromJson(completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
}

private extension AllPlantsJsonToCoreDataMapper {
    func loadPlantsListJson() -> Any? {
        let plantsListName = "plants_with_details_list_with_replaced_images_path"
        
        guard let path = Bundle.main.path(forResource: plantsListName, ofType: "json") else {
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
    
    func refillDataFromJson(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let plantsListJson = loadPlantsListJson() else {
            completion(.failure(ParseError.canNotParseJsonData))
            return
        }
        
        
        
    }
}

private extension AllPlantsJsonToCoreDataMapper {
    enum ParseError: Error {
        case canNotParseJsonData
    }
}
