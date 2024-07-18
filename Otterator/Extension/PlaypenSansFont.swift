//
//  PlaypenSansFont.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 18/07/24.
//

import SwiftUI

enum FontWeight {
    case thin
    case extraLight
    case light
    case regular
    case medium
    case semiBold
    case bold
    case black
}

extension Font {
    static let playpenSans: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .thin:
            Font.custom("PlaypenSans-Regular_Thin", size: size)
        case .light:
            Font.custom("PlaypenSans-Regular_Light", size: size)
        case .regular:
            Font.custom("PlaypenSans-Regular", size: size)
        case .medium:
            Font.custom("PlaypenSans-Regular_Medium", size: size)
        case .semiBold:
            Font.custom("PlaypenSans-Regular_SemiBold", size: size)
        case .bold:
            Font.custom("PlaypenSans-Regular_Bold", size: size)
        case .black:
            Font.custom("PlaypenSans-Regular_ExtraBold", size: size)
        case .extraLight:
            Font.custom("PlaypenSans-Regular_ExtraLight", size: size)
        }
    }
}

extension Text {
    func playpenSans(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        return self.font(.playpenSans(fontWeight ?? .regular, size ?? 16))
    }
}
