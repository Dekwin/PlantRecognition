//
//  PlantIdServiceProtocol.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.05.2021.
//

import Foundation
import Combine

protocol PlantIdServiceProtocol: AnyObject {
    func identify(request: PlantIdIdentifyRequest) -> AnyPublisher<PlantIdSuggestions, Error>
}
