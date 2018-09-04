//
//  Application.swift
//  TonyTony
//
//  Created by Лысенко Алексей Димитриевич on 04.09.2018.
//

import Foundation

protocol ApplicationEvent {
    func proceed()
}

protocol ApplicationDelegate: class {
    func applicationStartedMainLoop(_ application: Application)
}

class Application {
    static let shared = Application()
    
    private var eventsStack = [ApplicationEvent]()

    var keyWindow: Window?
    weak var delegate: ApplicationDelegate!
    
    func sendEvent(_ event: ApplicationEvent) {
        eventsStack.append(event)
    }
    
    func runMainLoop() {
        delegate.applicationStartedMainLoop(self)
        while true {
            while let lastEvent = eventsStack.popLast() {
                lastEvent.proceed()
            }
        }
    }
}
