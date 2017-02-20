//
//  HomeTableViewController.swift
//  Swift-Weibo
//
//  Created by ihealth-wyc on 16/11/7.
//  Copyright © 2016年 ihealth-wyc. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
 
        if !isLogin{
        
            visitorView?.setupVisitorInfo(imageName: nil, title: "首页")
            return
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:         UIImage(named:"navigationbar_friendattention")
            , style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeTableViewController.leftBtnOnClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:         UIImage(named:"navigationbar_pop")
            , style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeTableViewController.rightBtnOnClick))
    
        let titleButton = TitleButton()
        titleButton.setTitle("首页  ", for: UIControlState.normal)
        titleButton.setImage(UIImage(named:"navigationbar_arrow_down"), for: UIControlState.normal)
        titleButton.setImage(UIImage(named:"navigationbar_arrow_up"), for: UIControlState.selected)
        titleButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        titleButton.sizeToFit()
        titleButton .addTarget(self, action:#selector(HomeTableViewController.titleBtnOnClick) , for: UIControlEvents.touchUpInside)
        navigationItem.titleView = titleButton
    }
    
    @objc private func titleBtnOnClick(btn:TitleButton){
    
    btn.isSelected = !btn.isSelected
        
    let sb = UIStoryboard(name: "Popover", bundle: nil)
        guard let menuView = sb.instantiateInitialViewController() else {
    
            return
        }
        menuView.transitioningDelegate = animatormanager
        menuView.modalPresentationStyle = UIModalPresentationStyle.custom
        
        present(menuView, animated: true, completion: nil)
    }
    
    
    @objc  private func leftBtnOnClick(){
    
        
    }
    
    @objc private func rightBtnOnClick(){
        
        let sb = UIStoryboard.init(name: "QRCode", bundle: nil)
        let vc = sb.instantiateInitialViewController()!
        
        self.present(vc, animated: true, completion: nil)
        
    }
   
    private lazy var animatormanager = YCPresentationManager()

}

