//
//  PlantIdSuggestionDetails.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation

struct PlantIdSuggestionDetails: Equatable, Decodable {
    let commonNames: [String]
    
    private enum CodingKeys : String, CodingKey {
        case commonNames = "common_names"
    }
}
