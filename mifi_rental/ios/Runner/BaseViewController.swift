//
//  BaseViewController.swift
//  Runner
//
//  Created by yyg on 2020/5/14.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1.0)
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        
        setDefaultBackButton(selector: nil)
    }
    
    func setDefaultBackButton(selector: Selector?) {
        let barBtn = UIButton.init(type: .custom)
        barBtn.setImage(UIImage.init(named: "popIcon"), for: .normal)
        barBtn.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: barBtn)
        if selector == nil {
            barBtn.addTarget(self, action: #selector(popSelf), for: .touchUpInside)
        } else {
            barBtn.addTarget(self, action: selector!, for: .touchUpInside)
        }
    }
    
    @objc func popSelf() {
        self.navigationController?.popViewController(animated: true)
    }

}
