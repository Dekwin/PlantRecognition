//
//  Copyable.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 21.06.2021.
//

import Foundation

protocol Copyable {
    init(instance: Self)
}

extension Copyable {
    func copy() -> Self {
        return Self.init(instance: self)
    }
}
