//
//  HomePageКщгеук.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 24.05.2021.
//

import Foundation

protocol HomePageRouterProtocol: AnyObject {
    
}

final class HomePageRouter: HomePageRouterProtocol {
    private let transitionable: Transitionable
    
    init(transitionable: Transitionable) {
        self.transitionable = transitionable
    }
}
