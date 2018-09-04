//
//  Window.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 04.09.2018.
//

import Foundation

class ViewController {
    var view: View!
    
    init() {
        self.view = View()
        viewDidLoad()
    }
    
    func viewDidLoad() {}
}

class View {
    var frame: Rect
    
    init(frame: Rect) {
        self.frame = frame
    }
    
    convenience init() {
        self.init(frame: .zero)
    }

    func draw() {
        guard let screenBuffer = Application.shared.keyWindow?.screen.getCurrentBuffer() else { return }
        screenBuffer
    }
}

class Window {
    var rootViewController: ViewController?
    var screen: Screen
    
    init(screen: Screen) {
        self.screen = screen
    }
}
