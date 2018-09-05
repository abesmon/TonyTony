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

private var sharedApplication: Application?
class Application {
    static var shared: Application {
        guard let shared = sharedApplication else {
            sharedApplication = Application()
            return sharedApplication!
        }
        return shared
    }
    
    private var eventsStack = [ApplicationEvent]()

    var mainScreen: Screen? = ConsoleScreen()
    var rootViewController: ViewController?
    private(set) var mainLoopRunDate: Date?
    weak var delegate: ApplicationDelegate!
    
    func sendEvent(_ event: ApplicationEvent) {
        eventsStack.append(event)
    }
    
    func runMainLoop() {
        mainLoopRunDate = Date()
        delegate.applicationStartedMainLoop(self)
        while true {
            while let lastEvent = eventsStack.popLast() {
                lastEvent.proceed()
            }
            rootViewController?.update()
        }
    }
}
