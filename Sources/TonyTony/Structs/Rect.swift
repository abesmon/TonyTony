//
//  Rect.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 04.09.2018.
//

import Foundation

struct Rect {
    var origin: Point
    var size: Size
    
    var minX: Double {
        return origin.x
    }
    
    var maxX: Double {
        return origin.x + size.width - 1
    }
    
    var minY: Double {
        return origin.y
    }
    
    var maxY: Double {
        return origin.y + size.height - 1
    }
    
    static let zero = Rect(origin: .zero, size: .zero)
}
