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
    static let playpenSans: (FontWeight, CGFloat, TextStyle) -> Font = { fontType, size, textStyle in
        switch fontType {
        case .thin:
            Font.custom("PlaypenSans-Regular_Thin", size: size, relativeTo: textStyle)
        case .light:
            Font.custom("PlaypenSans-Regular_Light", size: size, relativeTo: textStyle)
        case .regular:
            Font.custom("PlaypenSans-Regular", size: size, relativeTo: textStyle)
        case .medium:
            Font.custom("PlaypenSans-Regular_Medium", size: size, relativeTo: textStyle)
        case .semiBold:
            Font.custom("PlaypenSans-Regular_SemiBold", size: size, relativeTo: textStyle)
        case .bold:
            Font.custom("PlaypenSans-Regular_Bold", size: size, relativeTo: textStyle)
        case .black:
            Font.custom("PlaypenSans-Regular_ExtraBold", size: size, relativeTo: textStyle)
        case .extraLight:
            Font.custom("PlaypenSans-Regular_ExtraLight", size: size, relativeTo: textStyle)
        }
    }
}

extension Text {
//    func playpenSans(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil, _ textStyle: Text? = nil) -> Text {
//        return self.font(.playpenSans(fontWeight ?? .regular, size ?? 16, .callout))
//    }
    func playpenSans(_ fontWeight: FontWeight? = nil, _ size: CGFloat? = nil, _ textStyle: Font? = nil) -> Text {
        return self.font(.playpenSans(fontWeight ?? .regular, size ?? 16, .callout))
    }
}
