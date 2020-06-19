import Flutter
import UIKit

public class SwiftNativeSystemDefaultConfigPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "native_system_default_config", binaryMessenger: registrar.messenger())
    let instance = SwiftNativeSystemDefaultConfigPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getPlatformVersion" {
        result("iOS " + UIDevice.current.systemVersion)
    } else if call.method == "getNativeDefaultLanguage" {
        let languageFirst = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String
        let separteStrs = languageFirst.split(separator: "-")
        let countryCode = String(separteStrs.last!)
        var languageCode = ""
        for i in 0..<separteStrs.count-1 {
            languageCode += separteStrs[i]
            languageCode += "-"
        }
        languageCode.remove(at: languageCode.index(before: languageCode.endIndex))
        result(["languageCode":languageCode, "countryCode":countryCode])
    } else {
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
