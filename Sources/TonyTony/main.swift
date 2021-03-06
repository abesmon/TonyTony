import Foundation


import PCD8544
import SwiftyGPIO

extension Color {
    var grayscale: Color {
        let middle = (red + green + blue) / 3
        return Color(red: middle, green: middle, blue: middle, alpha: alpha)
    }
}

class NokScreen: Screen {
    var pixelSize: GSize { return GSize(width: LCDWIDTH, height: LCDHEIGHT) }
    
    private let hardwDisplay: PCD8544
    init?() {
        let gpios = SwiftyGPIO.GPIOs(for: .OrangePiZero)
        guard let rst = gpios[.P7],
            let dc = gpios[.P25],
            let cs = gpios[.P8],
            let mosi = gpios[.P10],
            let miso = gpios[.P9],
            let clk = gpios[.P11]
            else {
                print("failed to get some of variables")
                return nil }
        let spi = VirtualSPI(mosiGPIO: mosi, misoGPIO: miso, clockGPIO: clk, csGPIO: cs)
        self.hardwDisplay = PCD8544(spi: spi, dc: dc, rst: rst, cs: cs)
    }
    
    func drawPixel(atPoint point: GPoint, color: Color) {
        let graysc = color.grayscale
        let lcdColor: LCDColor = graysc.red > (255/2) ? .WHITE : .BLACK
        hardwDisplay.setPixel(x: point.x, y: point.y, color: lcdColor)
    }
    
    func display() {
        hardwDisplay.display()
    }
    
    func clear() {
        hardwDisplay.clearDisplay()
    }
}

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
        print("application did runed")
        let redView = View(frame: Rect(origin: .zero, size: Size(width: 9, height: 9)))
        redView.backgroundColor = .red
        
        let viewController = FooViewController(view: redView)
        application.rootViewController = viewController
    }
}

func start() {
    func test() {
        let gpios = SwiftyGPIO.GPIOs(for: .OrangePiZero)
        guard let rst = gpios[.P7],
            let dc = gpios[.P25],
            let cs = gpios[.P8],
            let mosi = gpios[.P10],
            let miso = gpios[.P9],
            let clk = gpios[.P11]
            else {
                print("failed to get some of variables while test")
                return
        }
        let spi = VirtualSPI(mosiGPIO: mosi, misoGPIO: miso, clockGPIO: clk, csGPIO: cs)
        let hardwDisplay = PCD8544(spi: spi, dc: dc, rst: rst, cs: cs)
        hardwDisplay.draw(text: "test", x: 0, y: 0)
        hardwDisplay.display()
    }
    test()
    
    let application = Application.shared
    let screen = NokScreen()
    application.mainScreen = screen
    let mainAppDelegate = MainAppDelegate()
    application.delegate = mainAppDelegate
    application.runMainLoop()
}

start()
