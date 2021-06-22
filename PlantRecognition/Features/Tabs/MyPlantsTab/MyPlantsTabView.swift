//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

final class MyPlantsTabView: UIView {
    private let appearance = Appearance()
    private lazy var label = UILabel(frame: .zero)
    
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
private extension MyPlantsTabView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
        
        label.set(text: "My plants", with: .title32SB)
        
        let card = PlantCardView(frame: .zero)
        card.update(
            with: .init(image: Asset.Images.DemoImages.demoPlant.image, title: "Nephrolepis", notificationImages: [Asset.Images.Iconly.greenDroplet.image, Asset.Images.Iconly.greenFertilizer.image, Asset.Images.Iconly.greenPots.image])
        )
        addSubview(card)
        card.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.leading.equalTo(label.snp.leading)
        }
    }
    
    func setupSubviews() {
        addSubview(label)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(28)
            make.left.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
}

// MARK: - Model
extension MyPlantsTabView {
    struct Model {
        
    }
}

// MARK: - Appearance
private extension MyPlantsTabView {
    struct Appearance {
        
    }
}

