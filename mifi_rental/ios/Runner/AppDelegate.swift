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
            guard call.method == "payWebPage" else {
                result(FlutterMethodNotImplemented)
                return
            }
        }
        // EventChannel
        let eventChannel = FlutterEventChannel(name: "com.uklink.common/eventChannel",
                                               binaryMessenger: controller.binaryMessenger)
        eventChannel.setStreamHandler(self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        // 反初始化日志
        NativeLogHelper.deinitXlogger()
    }
}
