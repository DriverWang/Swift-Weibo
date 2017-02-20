//
//  ProfileTableViewController.swift
//  Swift-Weibo
//
//  Created by ihealth-wyc on 16/11/7.
//  Copyright © 2016年 ihealth-wyc. All rights reserved.
//

import UIKit

class ProfileTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogin{
            visitorView?.setupVisitorInfo(imageName:"visitordiscover_image_profile", title: "个人资料")
            return
        }
        
    }

  

}
