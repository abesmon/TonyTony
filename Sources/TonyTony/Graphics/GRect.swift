//
//  GRect.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 04.09.2018.
//

import Foundation

struct GRect {
    var origin: GPoint
    var size: GSize
    
    static let zero = GRect(origin: .zero, size: .zero)
}
