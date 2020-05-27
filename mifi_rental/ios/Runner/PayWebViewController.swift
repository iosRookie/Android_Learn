//
//  PayWebViewController.swift
//  Runner
//
//  Created by yyg on 2020/5/14.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import UIKit

class PayWebViewController: BaseViewController {//, WKNavigationDelegate, WKScriptMessageHandler  {
    var myWebView: DWKWebView = DWKWebView.init()

    var params: Dictionary<String , Any>? = nil
    var jsApi: JSApi? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "支付"
        
        self.setDefaultBackButton(selector: #selector(popAlert))
        self.jsApi = JSApi(params: params, viewController: self.navigationController)
        self.myWebView.addJavascriptObject(self.jsApi, namespace: nil)
        self.myWebView.setDebugMode(false)
        self.myWebView.setJavascriptCloseWindowListener {
            print("Javascript Close Window")
        }

        self.myWebView.load(URLRequest.init(url: URL.init(string: "https://saas82mph5.ukelink.net/pay/authPaypal")!))
        self.view.addSubview(self.myWebView)
        myWebView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
        
//        let successBtn = UIButton.init(type: .custom)
//        successBtn.frame = CGRect.init(x: 50, y: 100, width: 100, height: 100)
//        successBtn.backgroundColor = .red
//        successBtn.setTitle("success", for: .normal)
//        successBtn.addTarget(self, action: #selector(success), for: .touchUpInside)
//        self.view.addSubview(successBtn)
//
//        let failureBtn = UIButton.init(type: .custom)
//        failureBtn.frame = CGRect.init(x: 200, y: 100, width: 100, height: 100)
//        failureBtn.backgroundColor = .red
//        failureBtn.setTitle("failure", for: .normal)
//        failureBtn.addTarget(self, action: #selector(failure), for: .touchUpInside)
//        self.view.addSubview(failureBtn)
    }
    
//    @objc func success() {
//        self.jsApi?.jumpToNativePage("toPaySuccess")
//    }
//
//    @objc func failure() {
//        self.jsApi?.jumpToNativePage("toPayCancel")
//    }
    
    @objc func popAlert() {
        let alert = UIAlertController.init(title: "提示", message: "是否取消支付？", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true) {}
    }
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print("Finished")
//    }
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        print(navigationResponse)
//
//        decisionHandler(.allow)
//    }
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        print(navigationAction)
//        let navigationURL = navigationAction.request.url
//        if ((navigationURL?.absoluteString.contains("blob")) != nil) {
//            testDownloadBlob(navigationURL: navigationURL!)
//        }
//        decisionHandler(.allow)
//    }
//
//    func testDownloadBlob(navigationURL: URL) {
//
//        var script = ""
//        script = script + "var xhr = new XMLHttpRequest();"
//        script = script + "xhr.open('GET', '\(navigationURL.absoluteString)', true);"
//        script = script + "xhr.responseType = 'blob';"
//        script = script + "window.webkit.messageHandlers.readBlob.postMessage('making sure script called');"
//        script = script + "xhr.onload = function(e) { if (this.status == 200) { var blob = this.response; window.webkit.messageHandlers.readBlob.postMessage(blob); var reader = new window.FileReader(); reader.readAsBinaryString(blob); reader.onloadend = function() { window.webkit.messageHandlers.readBlob.postMessage(reader.result); }}};"
//        script = script + "xhr.send();"
//
//        self.myWebView.evaluateJavaScript(script) { (results, error) in
//            print(results ?? "")
//        }
//    }
//
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        print(message.name, message.body)
//    }

}
