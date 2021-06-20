//
//  TextStyle+Default.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 20.06.2021.
//

import Foundation
import UIKit

extension TextStyle {

    /// 32
    class var headerL: TextStyle {
        .init(
            styleAttributes: .init(font: Fonts.FiraSans.semiBold.font(size: 32), lineHeight: .defined(value: 34), alignment: .defined(value: .left))
        )
    }

    /// .bold27
    class var headerM: TextStyle {
        .init(styleAttributes: .init(font: Fonts.FiraSans.semiBold.font(size: 27)))
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
            styleAttributes: .init(font: Fonts.FiraSans.regular.font(size: 11), lineHeight: .defined(value: 13), alignment: .defined(value: .center))
        )
    }
}
