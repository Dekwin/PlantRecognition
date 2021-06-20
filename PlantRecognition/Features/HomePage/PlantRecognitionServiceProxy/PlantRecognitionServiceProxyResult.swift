//
//  PlantRecognitionServiceProxyResult.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 30.05.2021.
//

import Foundation

struct PlantRecognitionServiceProxyResult {
    let suggestions: [PlantSuggestion]
}

extension PlantRecognitionServiceProxyResult {
    struct PlantSuggestion {
        let name: String
        let probability: Double?
    }
}
