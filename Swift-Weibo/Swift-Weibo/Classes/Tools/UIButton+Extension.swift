//
//  UIButton+Extension.swift
//  Swift-Weibo
//
//  Created by ihealth-wyc on 16/11/9.
//  Copyright © 2016年 ihealth-wyc. All rights reserved.
//

import UIKit

extension UIButton{

     convenience init(imageName:String,backgroundImageName:String){
        
        self.init()
        
        setImage(UIImage(named:imageName), for: UIControlState.normal)
        setImage(UIImage(named:imageName + "_highlighted"), for: UIControlState.highlighted)
        setBackgroundImage(UIImage(named:backgroundImageName), for: UIControlState.normal)
        setBackgroundImage(UIImage(named:backgroundImageName + "_highlighted"), for: UIControlState.highlighted)
        sizeToFit()

    }

}
