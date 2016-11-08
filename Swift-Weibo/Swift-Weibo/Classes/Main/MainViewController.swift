//
//  MainViewController.swift
//  Swift-Weibo
//
//  Created by ihealth-wyc on 16/11/7.
//  Copyright © 2016年 ihealth-wyc. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.orange
        addChildViewControllers()

    }

    func addChildViewControllers()
    
    {
        guard let filePath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil)
            else{
            return
        }
        
        guard let data = NSData(contentsOfFile: filePath) else{
            return
        }
        
        do {
            let objc = try JSONSerialization.jsonObject(with: data as Data, options: []) as! [[String:AnyObject]]
            
            for dict in objc {
                
                let title = dict["title"]
                let vcName = dict["vcName"]
                let imageName = dict["imageName"]
                
                addChildViewController(childController: vcName as? String, title: title as? String, imageName: imageName as? String)
            }
            
        } catch {
            
                addChildViewController(childController: "HomeTableViewController", title: "首页", imageName: "tabbar_home")
                addChildViewController(childController: "MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
                addChildViewController(childController: "DiscoverTableViewController", title: "发现", imageName: "tabbar_discover")
                addChildViewController(childController: "ProfileTableViewController", title: "我", imageName: "tabbar_profile")
            
        }
        
    }
    
    func addChildViewController( childController: String? , title:String?, imageName:String? ) {

        guard let name = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String else {
            return
        }
        
        var cls:AnyClass? = nil
        
        if let vcName = childController {
             cls = NSClassFromString(name + "." + vcName)
        }
        
        guard let typeCls = cls as? UITableViewController.Type else {
            
            return
        }
        
        let childController = typeCls.init()
        
        childController.title = title
        
        if let ivneme = imageName {
            
            childController.tabBarItem.image = UIImage(named: ivneme)
            childController.tabBarItem.selectedImage = UIImage(named: ivneme + "_highlighted")

        }
        
        let nav = UINavigationController(rootViewController: childController)
    
        addChildViewController(nav);

    }
}
