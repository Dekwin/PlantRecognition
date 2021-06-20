//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

final class SearchTabView: UIView {
    private let appearance = Appearance()
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        
    }
}

// MARK: - Private methods
private extension SearchTabView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
}

// MARK: - Model
extension SearchTabView {
    struct Model {
        
    }
}

// MARK: - Appearance
private extension SearchTabView {
    struct Appearance {
        
    }
}

