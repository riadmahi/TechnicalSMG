//
//  Font+Extension.swift
//  TechnicalSMG
//
//  Created by Riad on 03/06/2025.
//

import SwiftUI

enum FontWeight {
    case light
    case regular
    case medium
    case semiBold
    case bold
    case black
}

extension Font {
    static let brSonomaFont: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .light:
            Font.custom("BRSonoma-Light", size: size)
        case .regular:
            Font.custom("BRSonoma-Regular", size: size)
        case .medium:
            Font.custom("BRSonoma-Medium", size: size)
        case .semiBold:
            Font.custom("BRSonoma-SemiBold", size: size)
        case .bold:
            Font.custom("BRSonoma-Bold", size: size)
        case .black:
            Font.custom("BRSonoma-Black", size: size)
        }
    }
}

extension Text {
    func brSonomaFont(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        return self.font(.brSonomaFont(fontWeight ?? .regular, size ?? 16))
    }
}

