//
//  JSApi.swift
//  Runner
//
//  Created by yyg on 2020/5/14.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias JSCallback = (String, Bool) -> Void

class JSApi: NSObject {

    var params: Dictionary<String , Any>? = nil
    weak var viewController: UINavigationController?
    
    init(params: Dictionary<String , Any>?, viewController: UINavigationController?) {
        self.params = params
        self.viewController = viewController
    }
    
    @objc func getInfo(_ arg: String) -> String? {
        self.params?.removeValue(forKey: "__callback_id__")
        self.params?.removeValue(forKey: "terminalSn")
        self.params?["langType"] = "zh-CN"
        self.params?["localeCode"] = "zh_CN"
        return JSON(self.params as Any).rawString()
    }
    
    @objc func jumpToNativePage(_ arg: String) -> String? {
        switch arg {
        case "toPaySuccess":
            // 支付完成到设备查询界面
            self.viewController?.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "paySuccess"), object: nil)
//            PlatformRouterImp.sharedInstance.open("query", urlParams: ["":""], exts: ["animated" : true]) { _ in }
            break
        case "toPayCancel", "repayAgain":
            // 关闭支付界面并且取消订单
            // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cancelOrder"), object: nil)
            self.viewController?.dismiss(animated: true, completion: nil)
            break
        case "toContactUsActivity":
            break
        default:
            break
        }
        return ""
    }
}
