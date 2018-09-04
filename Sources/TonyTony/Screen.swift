//
//  Screen.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 04.09.2018.
//

import Foundation

class ScreenBuffer {
    private weak var screenOwner: Screen!
    // [row, row, row]
    private(set) var buffer: [[Color]]
    
    init(screenOwner: Screen) {
        self.screenOwner = screenOwner
        let pixelWidth = screenOwner.pixelSize.width
        let pixelHeight = screenOwner.pixelSize.height
        // [[Color]](repeating: [Color](repeating: Color.clear, count: pixelWidth), count: pixelHeight)
        self.buffer = (0..<pixelHeight).map { _ in (0..<pixelWidth).map { _ in Color.clear } }
    }
    
    func sync() {
        screenOwner.draw(buffer: self)
    }
    
    func fill(rect: Rect, withColor color: Color) {
        
    }
}

protocol Screen: class {
    var pixelSize: GSize { get }
    var scale: Double { get }

    func draw(buffer: ScreenBuffer)
    func flush()
    
    func getCurrentBuffer() -> ScreenBuffer
}
