//
//  MyPlantsListView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 23.06.2021.
//

import Foundation
import UIKit

final class MyPlantsListView: UIView {
    private let appearance = Appearance()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        
    }
}

// MARK: - Private methods
private extension MyPlantsListView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
}

// MARK: - Model
extension MyPlantsListView {
    struct Model {
        
    }
}

// MARK: - Appearance
private extension MyPlantsListView {
    struct Appearance {
        
    }
}

