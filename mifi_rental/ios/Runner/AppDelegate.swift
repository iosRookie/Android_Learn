import UIKit
import Flutter
import core_log

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // 初始化日志
        NativeLogHelper.initXlogger()
        
        GeneratedPluginRegistrant.register(with: self)
        
        FlutterBoostPlugin.sharedInstance().startFlutter(with: PlatformRouterImp.sharedInstance) { (engine) in
            
        }
        
        let vc = FLBFlutterViewContainer.init()
        vc.setName("rent", params: [kPageCallBackId : "rent#1"])
//        vc.setName("device", params: [kPageCallBackId : "device#1"])
        let nav = UINavigationController.init(rootViewController: vc)
        nav.navigationBar.isHidden = true
        self.window.rootViewController = nav
        
        self.window.makeKeyAndVisible()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        // 反初始化日志
        NativeLogHelper.deinitXlogger()
    }
}
