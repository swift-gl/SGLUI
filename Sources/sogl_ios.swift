import UIKit
import GLKit

internal class AppDelegate: UIResponder, UIApplicationDelegate {
    
    typealias Options = [UIApplicationLaunchOptionsKey : Any]
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: Options? = nil) -> Bool {
        let frame = UIScreen.main.bounds
        let window = UIWindow(frame: frame)
        
        if let oglWindow = sglios.Application.shared.windows.first,
            let viewController = oglWindow.backing {
            window.rootViewController = viewController
        }
        
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}

internal class SwiftOpenGLViewController: GLKViewController {
    
    private var context: EAGLContext
    private var fps: Int?
    internal var frame: ((CGRect) -> ())?
    
    convenience init(context: EAGLContext, fps: Int? = nil) {
        self.context = context
        self.fps = fps
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.view as? GLKView)?.context = self.context
        
        if let fps = self.fps {
            self.preferredFramesPerSecond = fps
        }
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        let bounds = view.bounds
        self.frame?(bounds)
    }
}

public enum sglios {
    
    final public class Application {
        
        class Window {
            
            internal var backing: SwiftOpenGLViewController
            
            public init(context: EAGLContext, fps: Int? = nil) {
                self.backing = SwiftOpenGLViewController(context: context, fps: fps)
            }
            
            public func frame(_ action: (CGRect) -> ()) {
                self.backing.frame = action
            }
        }
        
        public static let shared = Application()
        
        public var windows: [Window] = [] {
            didSet {
                
            }
        }
        
        internal init() { }
        
        public func run() {
            _ = autoreleasepool {
                return UIApplicationMain(0, nil, nil, NSStringFromClass(AppDelegate.self))
            }
        }
    }
}
