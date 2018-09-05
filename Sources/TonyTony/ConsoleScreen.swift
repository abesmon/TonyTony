//
//  ConsoleScreen.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 05.09.2018.
//

import Foundation

private let WIDTH = 12
private let HEIGHT = 10
class ConsoleScreen: Screen {
    private var buffer: [[Color]]
    private var bufferIsDisplayed = false
    
    var pixelSize: GSize { return GSize(width: WIDTH, height: HEIGHT) }
    
    init() {
        buffer = (0..<HEIGHT).map { _ in (0..<WIDTH).map { _ in Color.clear } }
    }
    
    func drawPixel(atPoint point: GPoint, color: Color) {
        guard point.y < buffer.count,
            point.x < buffer.first!.count,
            point.y >= 0,
            point.x >= 0 else { return }
        buffer[point.y][point.x] = buffer[point.y][point.x].blend(withColor: color)
        bufferIsDisplayed = false
    }
    
    func display() {
        guard !bufferIsDisplayed else { return }
        
        func run() {
            let horizontalBar = (0..<buffer.first!.count).map { _ in "⬛️" }.joined(separator: "")+"⬛️⬛️"
            print(horizontalBar)
            buffer.forEach { pixelRow in
                let pixelRow = pixelRow.map { pixel in
                    switch pixel {
                    case .clear:
                        return "⬜️"
                    case .red:
                        return "🔴"
                    case .green:
                        return "💚"
                    case .blue:
                        return "💙"
                    default:
                        return "❓"
                    }
                    }.joined(separator: "")
                print("⬛️"+pixelRow+"⬛️")
            }
            bufferIsDisplayed = true
            print(horizontalBar)
        }

        let process = Process()
        process.launchPath = "/usr/bin/clear"
        process.terminationHandler = { _ in run() }
        process.launch()
    
    }
    
    func clear() {
        buffer = (0..<HEIGHT).map { _ in (0..<WIDTH).map { _ in Color.clear } }
        display()
    }
}
