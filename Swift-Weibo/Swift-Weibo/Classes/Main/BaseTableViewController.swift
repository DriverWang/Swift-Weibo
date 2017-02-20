//
//  BaseTableViewController.swift
//  Swift-Weibo
//
//  Created by ihealth-wyc on 16/11/9.
//  Copyright © 2016年 ihealth-wyc. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var isLogin = true
    
    var visitorView : VisitorView?
    
    override func loadView() {
    
        isLogin ? super.loadView() : setupVisitorView()
        
        
    }
    
    private func setupVisitorView(){
    
        visitorView = VisitorView.visitorView()
        view = visitorView
        visitorView?.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action:#selector(BaseTableViewController.register))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.plain, target: self, action:#selector(BaseTableViewController.login))
    
    }
 
}

extension BaseTableViewController : VisitorViewDelegate{

    func visitorViewDidClickLoginBtn(visior: VisitorView) {
        
    }

    func visitorViewDidClickRegisterBtn(visior: VisitorView) {
        
    }
    
    @objc   func login() {
        
    }
    @objc  func register() {
        
    }
    
}
