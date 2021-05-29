//
//  RequestConvertible+URLRequestConvertible.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation
import Alamofire

struct URLRequestConvertibleProxy: URLRequestConvertible {
    let requestConvertible: RequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        try requestConvertible.asURLRequest()
    }
}

extension RequestConvertible  {
    func toURLRequestConvertible() -> URLRequestConvertible {
        URLRequestConvertibleProxy(requestConvertible: self)
    }
}
