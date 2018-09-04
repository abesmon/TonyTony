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
    
    static let zero = Rect(origin: .zero, size: .zero)
}
