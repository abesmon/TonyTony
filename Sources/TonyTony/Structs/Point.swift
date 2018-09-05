//
//  Point.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 04.09.2018.
//

import Foundation

struct Point {
    var x: Double
    var y: Double
    
    static let zero = Point(x: 0, y: 0)
    
    // simply rounds to ground
    func toGPoint() -> GPoint {
        let xPixel = Int(x.rounded(.down))
        let yPixel = Int(y.rounded(.down))
        return GPoint(x: xPixel, y: yPixel)
    }
    
    func summedBy(x: Double) -> Point {
        return Point(x: self.x + x, y: y)
    }
    
    func summedBy(y: Double) -> Point {
        return Point(x: x, y: self.y + y)
    }
}

extension Point {
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
