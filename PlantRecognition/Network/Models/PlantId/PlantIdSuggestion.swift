//
//  PlantIdSuggestion.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.05.2021.
//

import Foundation

struct PlantIdSuggestion: Equatable, Decodable {
    let plantName: String
    let plantDetails: PlantIdSuggestionDetails
    
    private enum CodingKeys : String, CodingKey {
        case plantName = "plant_name"
        case plantDetails = "plant_details"
    }
}
