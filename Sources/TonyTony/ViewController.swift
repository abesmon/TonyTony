//
//  ViewController.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 05.09.2018.
//

import Foundation

class ViewController {
    var view: View!
    
    init(view: View) {
        self.view = view
        viewDidLoad()
    }
    
    convenience init() {
        self.init(view: View())
    }
    
    func viewDidLoad() {}
    
    func update() {
        view.draw()
        Application.shared.mainScreen?.display()
    }
}
