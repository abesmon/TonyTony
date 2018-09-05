import Foundation

class FooViewController: ViewController {
    private var greenView: View!
    private var blueView: View!

    private var lastUpdate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greenView = View(frame: Rect(origin: Point(x: 1, y: 1), size: Size(width: 3, height: 3)))
        greenView.backgroundColor = .green
        
        view.addSubview(greenView)
    }
    
    var pixelsPerSecond: Double = 1
    var isRightMovement: Double = 1

    override func update() {
        super.update()
        let updateTime = Date()
        let updateDif: TimeInterval = updateTime.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970
        if greenView.frame.maxX >= (greenView.superview?.frame.size.width ?? 0) {
            isRightMovement = -1
        }
        if greenView.frame.minX <= 0 {
            isRightMovement = 1
        }
        greenView.frame.origin = greenView.frame.origin.summedBy(x: updateDif * pixelsPerSecond * isRightMovement)
        lastUpdate = updateTime
    }
}

class MainAppDelegate: ApplicationDelegate {
    func applicationStartedMainLoop(_ application: Application) {
        let redView = View(frame: Rect(origin: .zero, size: Size(width: 9, height: 9)))
        redView.backgroundColor = .red
        
        let viewController = FooViewController(view: redView)
        application.rootViewController = viewController
    }
}

func start() {
    let red = Color.red
    var blue = Color.green
    blue.alpha = 0.1
    let blended = red.blend(withColor: blue).toCGColor()
    let application = Application.shared
    let mainAppDelegate = MainAppDelegate()
    application.delegate = mainAppDelegate
    application.runMainLoop()
}

start()
