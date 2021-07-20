//
//  PlantIdSuggestionDetails.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation

struct PlantIdSuggestionDetails: Equatable, Decodable {
    let commonNames: [String]?
    let wikiImage: WikiImage?
    
    private enum CodingKeys : String, CodingKey {
        case commonNames = "common_names"
        case wikiImage = "wiki_image"
    }
}

extension PlantIdSuggestionDetails {
    struct WikiImage: Equatable, Decodable {
        let value: URL
        
        private enum CodingKeys : String, CodingKey {
            case value = "value"
        }
    }
}
