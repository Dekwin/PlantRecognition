//
//  DemoHelper.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.06.2021.
//

import Foundation

protocol DemoHelperProtocol: AnyObject {
    var isDemoMode: Bool { get }
}

class DemoHelper {
    static let shared: DemoHelperProtocol = DemoHelper()
}

extension DemoHelper: DemoHelperProtocol {
    var isDemoMode: Bool {
        return false
    }
}
