import Flutter
import UIKit
import SwiftyJSON

public class SwiftCoreLogPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "core_log", binaryMessenger: registrar.messenger())
    let instance = SwiftCoreLogPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let log : String = JSON.init(call.arguments as Any).rawString(.utf8, options: .prettyPrinted) ?? ""
    
    switch call.method {
        case "i":
            FXLOG_INFO(log)
        case "d":
            FXLOG_DEBUG(log)
        case "e":
            FXLOG_ERROR(log)
        case "w":
            FXLOG_WARNING(log)
        default:
            FXLOG_ALL(log)
    }
    result("iOS " + UIDevice.current.systemVersion)
  }
}
