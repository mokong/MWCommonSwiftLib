//
//  UIColor_Extensions.swift
//  meijuplay
//
//  Created by MorganWang on 8/12/2021.
//

import Foundation
import UIKit

public extension UIColor {
    static let custom = MWCustomColor.self
    
    static private func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor {
                $0.userInterfaceStyle == .dark ? dark : light
            }
        } else {
            return light
        }
    }
    
    enum MWCustomColor {
        public static let primary: UIColor = dynamicColor(light: UIColor(hex: 0x367EF5), dark: UIColor(hex: 0x367EF5))
        public static let background: UIColor = dynamicColor(light: .white, dark: .white)
        public static let lightBackground: UIColor = dynamicColor(light: UIColor(hex: 0xF4F4F4), dark: UIColor(hex: 0xF4F4F4))
        public static let cellBackground: UIColor = dynamicColor(light: UIColor(hex: 0xFAFAFA), dark: UIColor(hex: 0xFAFAFA))
        public static let buttonBackground: UIColor = dynamicColor(light: UIColor(hex: 0xF0F2F4), dark: UIColor(hex: 0xF0F2F4))
        public static let dimBack: UIColor = dynamicColor(light: UIColor(hex: 0x1C1C1C), dark: UIColor(hex: 0x1C1C1C))
        public static let lightDimBack: UIColor = dynamicColor(light: UIColor(hex: 0x272727), dark: UIColor(hex: 0x272727))

        public static let line: UIColor = dynamicColor(light: UIColor(hex: 0xD4D4D4), dark: UIColor(hex: 0xD4D4D4))
        public static let cellSeperator: UIColor = dynamicColor(light: UIColor(hex: 0xF2F2F2), dark: UIColor(hex: 0xF2F2F2))
        public static let borderLine: UIColor = dynamicColor(light: UIColor(hex: 0xE1E1E1), dark: UIColor(hex: 0xE1E1E1))

        public static let hightlightText: UIColor = dynamicColor(light: UIColor(hex: 0x7C4CFE), dark: UIColor(hex: 0x7C4CFE))
        public static let primaryText: UIColor = dynamicColor(light: UIColor(hex: 0x000000), dark: UIColor(hex: 0x000000))
        public static let secondaryText: UIColor = dynamicColor(light: UIColor(hex: 0x484848), dark: UIColor(hex: 0x484848))
        public static let footerText: UIColor = dynamicColor(light: UIColor(hex: 0x888888), dark: UIColor(hex: 0x888888))
        public static let descText: UIColor = dynamicColor(light: UIColor(hex: 0xC0ABF7), dark: UIColor(hex: 0xC0ABF7))
        public static let subTitleText: UIColor = dynamicColor(light: UIColor(hex: 0xF2EDFF), dark: UIColor(hex: 0xF2EDFF))
        public static let whiteText: UIColor = dynamicColor(light: .white, dark: .white)

        public static let primaryButton: UIColor = dynamicColor(light: UIColor(hex: 0x367EF5), dark: UIColor(hex: 0x367EF5))
        public static let secondaryButton: UIColor = dynamicColor(light: UIColor(hex: 0x878787), dark: UIColor(hex: 0x878787))
        public static let normalButton: UIColor = dynamicColor(light: UIColor(hex: 0x272727), dark: UIColor(hex: 0x272727))
        public static let selectedButton: UIColor = dynamicColor(light: UIColor(hex: 0x2E7CF6), dark: UIColor(hex: 0x2E7CF6))
        public static let unabledButton: UIColor = dynamicColor(light: UIColor(hex: 0xD7CCF6), dark: UIColor(hex: 0xD7CCF6))
        
        public static let themeColor: UIColor = dynamicColor(light: UIColor(hex: 0x7C4CFE), dark: UIColor(hex: 0x7C4CFE))
        public static let lightThemeBackColor: UIColor = dynamicColor(light: UIColor(hex: 0x7C4CFE, alpha: 0.2), dark: UIColor(hex: 0x7C4CFE, alpha: 0.2))

    }
}

public extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255.0,
            G: CGFloat((hex >> 08) & 0xff) / 255.0,
            B: CGFloat((hex >> 00) & 0xff) / 255.0
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
    
    static func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        print(hexString)
        return hexString
     }

    static func colorWithHexString(hexString: String) -> UIColor {
        var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()

        print(colorString)
        let alpha: CGFloat = 1.0
        let red: CGFloat = self.colorComponentFrom(colorString: colorString, start: 0, length: 2)
        let green: CGFloat = self.colorComponentFrom(colorString: colorString, start: 2, length: 2)
        let blue: CGFloat = self.colorComponentFrom(colorString: colorString, start: 4, length: 2)

        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }

    static func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {

        let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
        let endIndex = colorString.index(startIndex, offsetBy: length)
        let subString = colorString[startIndex..<endIndex]
        let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
        var hexComponent: UInt32 = 0

        guard Scanner(string: String(fullHexString)).scanHexInt32(&hexComponent) else {
            return 0
        }
        let hexFloat: CGFloat = CGFloat(hexComponent)
        let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
        print(floatValue)
        return floatValue
    }
    
    class var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}
