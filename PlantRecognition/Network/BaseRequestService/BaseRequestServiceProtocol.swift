//
//  BaseRequestServiceProtocol.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation

protocol BaseRequestServiceProtocol: AnyObject {
    func requestDecodable<ResponseObject: Decodable>(
        _ request: RequestConvertible,
        completionHandler: @escaping (Result<ResponseObject, Error>) -> Void
    )
}
