//
//  BaseRequestReactiveServiceProtocol.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation
import Combine

protocol BaseRequestReactiveServiceProtocol: AnyObject {
    func requestDecodable<ResponseObject: Decodable>(
        _ request: RequestConvertible
    ) -> AnyPublisher<ResponseObject, Error>
}

extension BaseRequestService: BaseRequestReactiveServiceProtocol {
    func requestDecodable<ResponseObject: Decodable>(_ request: RequestConvertible) -> AnyPublisher<ResponseObject, Error> {
        return Deferred {
            Future() { promise in
                //            promise(.failure(NetworkError.commonNetwork))
                self.requestDecodable(request) { result in
                    promise(result)
                }
            }
        }.eraseToAnyPublisher()
    }
}
