import UIKit
import Flutter
import core_log
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // 初始化日志
        NativeLogHelper.initXlogger()
        // 谷歌地图
        GMSServices.provideAPIKey("AIzaSyCjBUP2pui2ADS_Ou1jMvHRnX0ALbCjBcQ")
        GeneratedPluginRegistrant.register(with: self)
        
        guard let controller = window?.rootViewController as? FlutterViewController else {
            fatalError("rootViewController is not type FlutterViewController")
        }
        // MethodChannel
        let methodChannel = FlutterMethodChannel(name: "com.uklink.common/methodChannel",
                                                     binaryMessenger: controller.binaryMessenger)
        methodChannel.setMethodCallHandler { [weak self](call, result) in
            if call.method == "payWebPage" {
                let payPage = PayWebViewController.init()
                payPage.params = call.arguments as! Dictionary<String, AnyObject>
                let nav = UINavigationController.init(rootViewController: payPage)
                nav.modalPresentationStyle = .fullScreen
                self?.window.rootViewController?.present(nav, animated: true, completion: nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        // EventChannel
        let eventChannel = FlutterEventChannel(name: "com.uklink.common/payPageState",
                                               binaryMessenger: controller.binaryMessenger)
        eventChannel.setStreamHandler(self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cancelOrder), name: NSNotification.Name(rawValue: "cancelOrder"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(paySuccess), name: NSNotification.Name(rawValue: "paySuccess"), object: nil)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        // 反初始化日志
        NativeLogHelper.deinitXlogger()
    }
    
    @objc func cancelOrder(notification: Notification) {
        let params = notification.object as! Dictionary<String, String>
        self.eventSink!(["method": "cancelOrder", "orderSn": params["orderSn"]])
    }
    
    @objc func paySuccess() {
        self.eventSink!(["method": "paySuccess"])
    }
}
