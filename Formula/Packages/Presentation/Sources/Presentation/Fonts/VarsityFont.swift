//
//  VarsityFont.swift
//
//
//  Created by Bakar Kharabadze on 7/21/24.
//

import SwiftUI
import CoreGraphics
import CoreText

public enum Varsity: String, CaseIterable {
    case regular = "varsity_regular"
}

extension Font {
    public static func varsity(_ varsity: Varsity, size: CGFloat) -> Font {
        return .custom(varsity.rawValue, size: size, relativeTo: .body)
    }
}

public struct VarsityFont {
    public static func registerFonts() {
        Varsity.allCases.forEach {
            registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "ttf")
        }
    }

    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
        }
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            print("Failed to register font: \(fontName), error: \(String(describing: error))")
        }
    }
}
