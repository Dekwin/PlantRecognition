//
//  PlantRecognitionServiceProxyResult.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 30.05.2021.
//

import Foundation

struct PlantRecognitionServiceProxyResult {
    let resultType: ResultType
}

extension PlantRecognitionServiceProxyResult {
    enum ResultType {
        case notRecognizedError
        case recognized(plantIdentity: PlantIdentityInfo, probability: Double?)
    }
}

