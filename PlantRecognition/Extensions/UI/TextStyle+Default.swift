//
//  TextStyle+Default.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 20.06.2021.
//

import Foundation
import UIKit

extension TextStyle {
    
    class var title32SB: TextStyle {
        .init(
            styleAttributes: .init(
                font: Fonts.FiraSans.semiBold.font(size: 32),
                kern: .defined(value: 0.96),
                lineHeight: .defined(value: 38),
                alignment: .defined(value: .left),
                color: .defined(value: Asset.Colors.black.color)
            )
        )
    }
    
    class var subtitle18M: TextStyle {
        .init(
            styleAttributes: .init(
                font: Fonts.FiraSans.medium.font(size: 18),
                kern: .defined(value: 0.54),
                lineHeight: .defined(value: 22),
                alignment: .defined(value: .left),
                color: .defined(value: Asset.Colors.black.color)
            )
        )
    }
    
    class var subtitle16M: TextStyle {
        .init(
            styleAttributes: .init(
                font: Fonts.FiraSans.medium.font(size: 16),
                kern: .defined(value: 0.48),
                lineHeight: .defined(value: 19),
                alignment: .defined(value: .left),
                color: .defined(value: Asset.Colors.black.color)
            )
        )
    }
    
    class var text14R: TextStyle {
        .init(
            styleAttributes: .init(
                font: Fonts.FiraSans.regular.font(size: 14),
                kern: .defined(value: 0.42),
                lineHeight: .defined(value: 14),
                alignment: .defined(value: .left),
                color: .defined(value: Asset.Colors.black.color)
            )
        )
    }
    
    class var text16R: TextStyle {
        .init(
            styleAttributes: .init(
                font: Fonts.FiraSans.regular.font(size: 16),
                kern: .defined(value: 0.48),
                lineHeight: .defined(value: 19),
                alignment: .defined(value: .center),
                color: .defined(value: Asset.Colors.black.color)
            )
        )
    }
    
    class var text9M: TextStyle {
        .init(
            styleAttributes: .init(
                font: Fonts.FiraSans.regular.font(size: 9),
                kern: .defined(value: 0.27),
                lineHeight: .defined(value: 11),
                alignment: .defined(value: .center),
                color: .defined(value: Asset.Colors.white.color)
            )
        )
    }

//    /// .bold22
//    class var headerS: TextStyle {
//        .init(font: .bold22, kern: 0.35, lineSpacing: 2.0, lineHeight: 28.0)
//    }
//
//    /// .bold17
//    class var headerXS: TextStyle {
//        .init(font: .bold17, kern: -0.41, lineSpacing: 4.0, lineHeight: 24.0)
//    }
//
//    /// .medium17
//    class var mediumText: TextStyle {
//        .init(font: .medium17, kern: -0.41, lineSpacing: 4.0, lineHeight: 24.0)
//    }
//
//    /// .regular17
//    class var bodyText: TextStyle {
//        .init(font: .regular17, kern: -0.41, lineSpacing: 4.0, lineHeight: 24.0)
//    }
//
//    /// .bold15
//    class var headerXXS: TextStyle {
//        .init(font: .bold15, kern: -0.24, lineSpacing: 2.0, lineHeight: 20.0)
//    }
//
//    /// .regular15
//    class var secondaryText: TextStyle {
//        .init(font: .regular15, kern: -0.24, lineSpacing: 2.0, lineHeight: 20.0)
//    }
//
//    /// .regular13
//    class var captionText: TextStyle {
//        .init(font: .regular13, kern: -0.08, lineSpacing: 2.0, lineHeight: 18.0)
//    }
    
    /// .11
    class var tabsText: TextStyle {
        .init(
            styleAttributes: .init(
                font: Fonts.FiraSans.regular.font(size: 11),
                lineHeight: .defined(value: 13),
                alignment: .defined(value: .center)
            )
        )
    }
}
