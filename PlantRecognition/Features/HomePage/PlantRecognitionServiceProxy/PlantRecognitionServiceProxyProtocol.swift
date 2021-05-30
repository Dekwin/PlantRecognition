//
//  PlantRecognitionServiceProxy.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 26.05.2021.
//

import Foundation
import UIKit

protocol PlantRecognitionServiceProxyProtocol: AnyObject {
    func recognize(image: UIImage, completion: @escaping (Result<PlantRecognitionServiceProxyResult, Error>) -> Void)
}
