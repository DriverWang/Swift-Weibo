//
//  YCPresentationController.swift
//  Swift-Weibo
//
//  Created by ihealth-wyc on 16/11/15.
//  Copyright © 2016年 ihealth-wyc. All rights reserved.
//

import UIKit

class YCPresentationController: UIPresentationController {

    override func containerViewWillLayoutSubviews() {
        
        presentedView?.frame = CGRect(x: 100, y: 45, width: 200, height: 200)
        containerView?.insertSubview(coverButton, at: 0)
        coverButton.addTarget(self, action: #selector(YCPresentationController.coverBtnClick), for: UIControlEvents.touchUpInside)

    }
    
    @objc private func coverBtnClick()
    {
    
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    private lazy var coverButton:UIButton = {
        
        let btn = UIButton()
        btn.frame = UIScreen.main.bounds
        btn.backgroundColor = UIColor.clear
        return btn
    
    }()
    
}
