//
//  View.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 05.09.2018.
//

import Foundation

class View {
    var frame: Rect
    var backgroundColor: Color = .clear

    fileprivate(set) var superview: View?
    private(set) var subviews = [View]()
    
    init(frame: Rect) {
        self.frame = frame
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    func addSubview(_ view: View) {
        subviews.append(view)
        view.superview = self
    }
    
    func draw() {
        guard let mainScreen = Application.shared.mainScreen else { return }
        
        func getAllSuperFrames(startingFrom view: View) -> [Rect] {
            let frames = [view.frame]
            if let superview = view.superview {
                return frames + getAllSuperFrames(startingFrom: superview)
            }
            return frames
        }
        let absoluteOrigin = getAllSuperFrames(startingFrom: self).map { $0.origin }.reduce(.zero, +)
        let pixelAbsoluteOrigin = absoluteOrigin.toGPoint()
        let pixelSize = frame.size.toGSize()
        (0..<pixelSize.height).forEach { row in
            (0..<pixelSize.width).forEach { column in
                let pixel = GPoint(x: pixelAbsoluteOrigin.x + column, y: pixelAbsoluteOrigin.y + row)
                mainScreen.drawPixel(atPoint: pixel, color: backgroundColor)
            }
        }
        subviews.forEach { $0.draw() }
    }
}
