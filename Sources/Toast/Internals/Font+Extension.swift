//
//  File.swift
//  swiftui-toasts
//
//  Created by Jaykishan Moradiya on 04/04/25.
//

import Foundation
import UIKit
import CoreText

public class FontLoader {
    public static func registerFonts() {
        let fontNames = ["Urbanist-Medium", "Urbanist-Italic"] // Add all your font names here

        for fontName in fontNames {
            guard let fontURL = Bundle.module.url(forResource: fontName, withExtension: "ttf") ??
                                Bundle.module.url(forResource: fontName, withExtension: "otf") else {
                print("⚠️ Font \(fontName) not found in the package resources.")
                continue
            }

            guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
                  let font = CGFont(fontDataProvider) else {
                print("⚠️ Failed to create font: \(fontName)")
                continue
            }

            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(font, &error) {
                print("⚠️ Error registering font \(fontName): \(error?.takeRetainedValue().localizedDescription ?? "Unknown error")")
            } else {
                print("✅ Successfully registered font: \(fontName)")
            }
        }
    }
}

extension UIDevice {
    var isIpad: Bool {
        return userInterfaceIdiom == .pad
    }

    var isIphone: Bool {
        return userInterfaceIdiom == .phone
    }
}
