//
//  VisitorView.swift
//  Swift-Weibo
//
//  Created by ihealth-wyc on 16/11/9.
//  Copyright © 2016年 ihealth-wyc. All rights reserved.
//

import UIKit

protocol VisitorViewDelegate:NSObjectProtocol {
    
    func visitorViewDidClickLoginBtn(visior:VisitorView)
    func visitorViewDidClickRegisterBtn(visior:VisitorView)

}


class VisitorView: UIView {

    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
 
    weak var delegate : VisitorViewDelegate?
    
    func setupVisitorInfo(imageName:String? , title:String){
    
        titleLabel.text = title
        
        guard let name = imageName else {
            
            startAniamtion()
            return
        }
        
        rotationView.isHidden = true

        iconView.image = UIImage(named: name)

    }

    private func startAniamtion(){
    
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.duration = 5.0
        anim.repeatCount = MAXFLOAT
        
        anim.isRemovedOnCompletion = false
        rotationView.layer.add(anim, forKey: nil)
    
    }
    
    class func visitorView ()->VisitorView{
        
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.last as! VisitorView
    
    }
    
    @IBAction func RegisterBtnOnClick(_ sender: UIButton) {
        delegate?.visitorViewDidClickRegisterBtn(visior: self)
    }
    
    @IBAction func loginBtnOnClick(_ sender: UIButton) {
        delegate?.visitorViewDidClickLoginBtn(visior: self)

    }
   
}
