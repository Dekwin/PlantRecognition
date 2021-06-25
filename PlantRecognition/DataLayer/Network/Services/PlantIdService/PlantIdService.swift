//
//  PlantIdService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation
import Alamofire

class PlantIdService: PlantIdServiceProtocol {
    private let session: Session = Session.default
    private let baseUrl: URL = URL(string: "https://api.plant.id/v2")!
    
    init() {
    }
    
    func identify(request: PlantIdIdentifyRequest, completion: @escaping (Result<PlantIdSuggestions, Error>) -> Void) {
        session
            .request(
                Router.identify(request: request)
            )
            .validate()
            .responseDecodable { result in
                completion(result.toResult())
            }
    }
}

private extension PlantIdService {
    enum Router: URLRequestConvertible {
        case identify(request: PlantIdIdentifyRequest)
        
        var baseURL: URL {
            return URL(string: "https://api.plant.id/v2")!
        }
        
        var authHeaders: HTTPHeaders {
            [
                "Api-Key": "eydsbcoFqucrfO9Em9olhdc4SjBMmQsi6JRP9uYnGhQjkKNKh8",
                "Content-Type": "application/json"
            ]
        }
        
        var method: HTTPMethod {
            switch self {
            case .identify(_): return .post
            }
        }
        
        var path: String {
            switch self {
            case .identify(_): return "identify"
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let url = baseURL.appendingPathComponent(path)
            var request = URLRequest(url: url)
            request.method = method
            request.headers = authHeaders
            
            switch self {
            case let .identify(req):
                request = try JSONParameterEncoder().encode(req, into: request)
            }
            
            return request
        }
    }
}

private extension DataResponse {
    func toResult() -> Result<Success, Error> {
        if let error = self.error {
            return .failure(error)
        } else if let value = self.value {
            return .success(value)
        } else {
            return .failure(NetworkError.noDecodedResult)
        }
    }
}
