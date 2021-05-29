//
//  PlantIdService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation
import Combine

class PlantIdService: PlantIdServiceProtocol {
    private let baseService: BaseRequestReactiveServiceProtocol
    private let baseUrl: URL = URL(string: "https://api.plant.id/v2")!
    
    init(baseService: BaseRequestReactiveServiceProtocol) {
        self.baseService = baseService
    }
    
    func identify(request: PlantIdIdentifyRequest) -> AnyPublisher<PlantIdSuggestions, Error> {
        let headers = [
            "Api-Key": "eydsbcoFqucrfO9Em9olhdc4SjBMmQsi6JRP9uYnGhQjkKNKh8",
            "Content-Type": "application/json"
        ]
        
        
        let images = request.images.map { $0.toBase64String() }
        
        let params: [String: Any] = [
            "images": [images],
            "modifiers": [],
            "plant_details": request.plantDetails
        ]
        
        return baseService
            .requestDecodable(
                RequestConvertibleObject(
                    baseURL: baseUrl,
                    path: "/identify",
                    method: .post,
                    headers: headers,
                    parameters: params
                )
            )
    }
}

private extension PlantIdService {
    struct RequestConvertibleObject: RequestConvertible {
        let baseURL: URL
        let path: String
        let method: RequestConvertibleHTTPMethod
        let headers: [String: String]
        let parameters: [String: Any]
        
        func asURLRequest() throws -> URLRequest {
            let url = baseURL.appendingPathComponent(path)
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
            
            switch method {
            case .get:
                break
            case .post:
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            }
            
            return request
        }
    }
}
