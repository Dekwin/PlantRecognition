//
//  PlantIdServiceProtocol.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.05.2021.
//

import Foundation

protocol PlantIdServiceProtocol: AnyObject {
    func identify(
        request: PlantIdIdentifyRequest,
        completion: @escaping (Result<PlantIdSuggestions, Error>) -> Void
    )
}
