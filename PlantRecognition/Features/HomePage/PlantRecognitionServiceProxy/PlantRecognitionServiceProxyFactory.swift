//
//  PlantRecognitionServiceProxy.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 30.05.2021.
//

import Foundation

final class PlantRecognitionServiceProxyFactory {
    func create(isDemo: Bool) -> PlantRecognitionServiceProxyProtocol {
        return isDemo
            ? PlantRecognitionDemoServiceProxy()
            : PlantIdPlantRecognitionServiceProxy(
                plantIdService: PlantIdService()
            )
    }
}
