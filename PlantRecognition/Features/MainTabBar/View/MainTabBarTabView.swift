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
    private let tabBarHeight: CGFloat = 70.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = tabBarHeight
        return sizeThatFits
    }
    
    private func setupTabBar() {
        clipsToBounds = false
        
        let bgView = UIImageView(image: Asset.TabBar.tabBarBg.image)
        addSubview(bgView)
        sendSubviewToBack(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: -26, left: 0, bottom: 0, right: 0))
        }

        shadowImage = UIImage()
        backgroundImage = UIImage()
        
        tintColor = UIColor(red: 65/255.0, green: 109/255.0, blue: 80/255.0, alpha: 1)
        unselectedItemTintColor = UIColor(red: 169/255.0, green: 177/255.0, blue: 170/255.0, alpha: 1)
    }
}
