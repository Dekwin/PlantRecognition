//  Created by Igor Kasyanenko on 20.06.2021.
//

import Foundation
import UIKit

class TextStyle {
    private(set) var styleAttributes: StyleAttributes
    
    init(styleAttributes: StyleAttributes) {
        self.styleAttributes = styleAttributes
    }
    
    func createAttributedText(from text: String) -> NSMutableAttributedString {
        let mutableAttributedText = NSMutableAttributedString(string: text)
        let paragraphStyle = createParagraphStyle()
        var textAttributes: [NSAttributedString.Key : Any] = [
            .paragraphStyle: paragraphStyle,
            .font: styleAttributes.font
        ]
        
        if let kern = styleAttributes.kern.value {
            textAttributes[.kern] = kern
        } else {
            textAttributes.removeValue(forKey: .kern)
        }
        
        if let foregroundColor = styleAttributes.color.value {
            textAttributes[.foregroundColor] = foregroundColor
        } else {
            textAttributes.removeValue(forKey: .foregroundColor)
        }
        
        var attributes = styleAttributes.attributes.value ?? [:]
        
        textAttributes.forEach { key, value in
            attributes.updateValue(value, forKey: key)
        }
        styleAttributes.attributes = .defined(value: attributes)
        
        mutableAttributedText.addAttributes(
            attributes,
            range: NSMakeRange(0, mutableAttributedText.length)
        )
        
        return mutableAttributedText
    }
    
    private func createParagraphStyle() -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        if let value = styleAttributes.lineHeight.value {
            paragraphStyle.minimumLineHeight = value
            paragraphStyle.maximumLineHeight = value
        }
        if let value = styleAttributes.alignment.value {
            paragraphStyle.alignment = value
        }
        if let value = styleAttributes.lineBreakMode.value {
            paragraphStyle.lineBreakMode = value
        }
        if let value = styleAttributes.lineSpacing.value {
            paragraphStyle.lineSpacing = value
        }
        return paragraphStyle
    }
}

extension TextStyle {
    struct StyleAttributes {
        let font: UIFont
        var kern: AttributeValue<Double> = .notDefined
        var lineSpacing: AttributeValue<CGFloat> = .notDefined
        var lineHeight: AttributeValue<CGFloat> = .notDefined
        var attributes: AttributeValue<[NSAttributedString.Key : Any]> = .defined(value: [:])
        var alignment: AttributeValue<NSTextAlignment> = .defined(value: .left)
        var lineBreakMode: AttributeValue<NSLineBreakMode> = .defined(value: .byTruncatingTail)
        var color: AttributeValue<UIColor> = .notDefined
    }
}

extension TextStyle.StyleAttributes {
    enum AttributeValue<Type> {
        case defined(value: Type)
        case notDefined
        
        var value: Type? {
            switch  self {
            case .defined(let value):
                return value
            case .notDefined:
                return nil
            }
        }
    }
}

