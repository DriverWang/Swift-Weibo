//
//  TitleButton.swift
//  Swift-Weibo
//
//  Created by ihealth-wyc on 16/11/14.
//  Copyright © 2016年 ihealth-wyc. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
//        titleLabel?.frame.offsetBy(dx: -imageView!.frame.width, dy: 0)
//        imageView?.frame.offsetBy(dx: titleLabel!.frame.width, dy: 0)
       
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.width
    }
}
