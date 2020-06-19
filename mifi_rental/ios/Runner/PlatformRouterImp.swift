//
//  PlatformRouterImp.swift
//  Runner
//
//  Created by yyg on 2020/3/17.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import UIKit

class PlatformRouterImp: NSObject {//, FLBPlatform {
    
    static let sharedInstance: PlatformRouterImp = PlatformRouterImp()
    private override init() {
        
    }
    
    func open(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
//        var animated = false
//        if exts["animated"] != nil {
//            animated = exts["animated"] as! Bool
//        }
//
//        if (url == "pay_native") {
//            let vc = PayWebViewController.init()
//            vc.params = urlParams as? Dictionary<String, Any>
//            self.navigationController().pushViewController(vc, animated:animated)
//        } else if (url == "device") {
//            let vc = FLBFlutterViewContainer.init()
//            vc.setName(url, params: urlParams)
//            vc.title = "设备"
//            let nav = UINavigationController.init(rootViewController: vc)
//            nav.navigationBar.isHidden = true
//            UIApplication.shared.keyWindow?.rootViewController = nav
//        } else if (url == "rent") {
//            let vc = FLBFlutterViewContainer.init()
//            vc.setName(url, params: urlParams)
//            let nav = UINavigationController.init(rootViewController: vc)
//            nav.navigationBar.isHidden = true
//            UIApplication.shared.keyWindow?.rootViewController = nav
//        } else {
//            let vc = FLBFlutterViewContainer.init()
//            vc.setName(url, params: urlParams)
//            self.navigationController().pushViewController(vc, animated:animated)
//        }
//        if url == "success" {
//            self.navigationController().interactivePopGestureRecognizer?.isEnabled = false
//        } else {
//            self.navigationController().interactivePopGestureRecognizer?.isEnabled = true
//        }
        completion(true)
    }
    
    func present(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
//        var animated = false
//        if exts["animated"] != nil {
//            animated = exts["animated"] as! Bool
//        }
//        let vc = FLBFlutterViewContainer.init()
//        vc.setName(url, params: urlParams)
//        navigationController().present(vc, animated: animated) {
//            completion(true)
//        }
    }
    
    func close(_ uid: String, result: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
//        var animated = false
//        if exts["animated"] != nil {
//            animated = exts["animated"] as! Bool
//        }
//
//        let presentedVC = self.navigationController().presentingViewController
//        let vc = presentedVC as? FLBFlutterViewContainer
//        if vc?.uniqueIDString() == uid {
//            vc?.dismiss(animated: animated, completion: {
//                completion(true)
//            })
//        } else {
//            self.navigationController().popViewController(animated: false)
//        }
    }
    
    func navigationController() -> UINavigationController {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let navigationController = delegate.window?.rootViewController as! UINavigationController
        return navigationController
    }

}
