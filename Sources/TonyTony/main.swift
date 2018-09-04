
class ConsoleScreen: Screen {
    var pixelSize: Size { return Size(width: 10, height: 10) }
    
    func draw(buffer: ScreenBuffer) {
        let pixelWidth = pixelSize.width
        //context.buffer.for
    }
    
    func flush() {
        <#code#>
    }
    
    
}


class MainApplicationDelegate: ApplicationDelegate {
    func applicationStartedMainLoop(_ application: Application) {
        let window = Window(screen: ConsoleScreen())
        window.rootViewController = ViewController()
        application.keyWindow = window
    }
}


func start() {
    let sharedApplication = Application.shared
    let mainApplicationDelegate = MainApplicationDelegate()
    sharedApplication.delegate = mainApplicationDelegate
    sharedApplication.runMainLoop()
}

start()
