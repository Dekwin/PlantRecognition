//
//  RequestConvertible.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation

protocol RequestConvertible {
    func asURLRequest() throws -> URLRequest
}

enum RequestConvertibleHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
