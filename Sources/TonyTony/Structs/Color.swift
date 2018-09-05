//
//  Color.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 04.09.2018.
//

import Foundation

enum BlendMode {
    case normal
}

struct Color {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double
    
    init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.red = min(max(0, red), 255)
        self.green = min(max(0, green), 255)
        self.blue = min(max(0, blue), 255)
        self.alpha = min(max(0, alpha), 1)
    }
    
    static let clear = Color(red: 0, green: 0, blue: 0, alpha: 0)
    static let white = Color(red: 255, green: 255, blue: 255, alpha: 1)
    static let red = Color(red: 255, green: 0, blue: 0, alpha: 1)
    static let green = Color(red: 0, green: 255, blue: 0, alpha: 1)
    static let blue = Color(red: 0, green: 0, blue: 255, alpha: 1)
    
    func blend(withColor addedColor: Color, blendMode: BlendMode = .normal) -> Color {
        switch blendMode {
        case .normal:
            let alpha = 1 - (1 - addedColor.alpha) * (1 - self.alpha); // alpha
            let red = round(
                (addedColor.red * addedColor.alpha / alpha)
                    + (self.red * self.alpha * (1 - addedColor.alpha) / alpha)
            ); // red
            let green = round(
                (addedColor.green * addedColor.alpha / alpha)
                    + (self.green * self.alpha * (1 - addedColor.alpha) / alpha)
            ); // green
            let blue = round(
                (addedColor.blue * addedColor.alpha / alpha)
                    + (self.blue * self.alpha * (1 - addedColor.alpha) / alpha)
            ); // blue
            return Color(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
}

#if os(OSX)
import CoreGraphics
extension Color {
    func toCGColor() -> CGColor {
        return CGColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: CGFloat(alpha))
    }
}
#endif

extension Color: Equatable {
    static func ==(lhs: Color, rhs: Color) -> Bool {
        return lhs.red == rhs.red &&
            lhs.green == rhs.green &&
            lhs.blue == rhs.blue &&
            lhs.alpha == rhs.alpha
    }
}
