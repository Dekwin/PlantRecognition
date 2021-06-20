//
//  MainTabBarTabView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 20.06.2021.
//

import Foundation
import UIKit
import SnapKit

class MainTabBarTabView: UITabBar {
    private let appearance = Appearance()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = appearance.tabBarHeight
        return sizeThatFits
    }
    
    private func setupTabBar() {
        clipsToBounds = false
        
        let bgView = UIImageView(image: Asset.Images.TabBar.tabBarBg.image)
        addSubview(bgView)
        sendSubviewToBack(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(appearance.bgImageInsets)
        }

        shadowImage = UIImage()
        backgroundImage = UIImage()
        
        tintColor = appearance.tintColor
        unselectedItemTintColor = appearance.unselectedItemTintColor
    }
}

private extension MainTabBarTabView {
    struct Appearance {
        let tintColor: UIColor = Asset.Colors.mainGreen.color
        let unselectedItemTintColor: UIColor = Asset.Colors.grey.color
        let tabBarHeight: CGFloat = 70.0
        let bgImageInsets: UIEdgeInsets = UIEdgeInsets(top: -26, left: 0, bottom: 0, right: 0)
    }
}
