//
//  Window.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 04.09.2018.
//

import Foundation

class Window {
    var rootViewController: ViewController?
    var screen: Screen
    
    init(screen: Screen) {
        self.screen = screen
    }
}
