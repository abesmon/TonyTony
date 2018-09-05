//
//  Screen.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 04.09.2018.
//

import Foundation

protocol Screen {
    var pixelSize: GSize { get }
    func drawPixel(atPoint point: GPoint, color: Color)
    func display()
    func clear()
}
