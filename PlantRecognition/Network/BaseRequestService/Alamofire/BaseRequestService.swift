//
//  BaseRequestService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation
import Alamofire

class BaseRequestService {
    private let session = Session.default
    
}

extension BaseRequestService: BaseRequestServiceProtocol {
    func requestDecodable<ResponseObject: Decodable>(
        _ request: RequestConvertible,
        completionHandler: @escaping (Result<ResponseObject, Error>) -> Void
    ) {
        session
            .request(request.toURLRequestConvertible())
            .validate()
            .responseDecodable(of: ResponseObject.self) { response in
                if let error = response.error {
                    completionHandler(.failure(error))
                } else if let value = response.value {
                    completionHandler(.success(value))
                } else {
                    completionHandler(.failure(NetworkError.noDecodedResult))
                }
            }
    }
}
