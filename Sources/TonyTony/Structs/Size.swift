//
//  Size.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 04.09.2018.
//

import Foundation

struct Size {
    var width: Double
    var height: Double
    
    static let zero = Size(width: 0, height: 0)
    
    func toGSize() -> GSize {
        let pixelWidth = Int(width.rounded(.down))
        let pixelHeight = Int(height.rounded(.down))
        return GSize(width: pixelWidth, height: pixelHeight)
    }
}
