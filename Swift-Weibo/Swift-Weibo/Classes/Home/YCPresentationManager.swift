//
//  YCPresentationManager.swift
//  Swift-Weibo
//
//  Created by ihealth-wyc on 16/11/24.
//  Copyright © 2016年 ihealth-wyc. All rights reserved.
//

import UIKit

class YCPresentationManager: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {

    private var isPresent = false
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?{
            
            return YCPresentationController(presentedViewController: presented, presenting: presenting)
        }
        
        func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            
            isPresent = true
            
            return self
        }
        
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            
            isPresent = false
            
            return self
            
        }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        
        return 998
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        if isPresent {
            guard  let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                return
            }
            
            
            transitionContext.containerView.addSubview(toView)
            
            toView.transform = CGAffineTransform(scaleX: 1.0,y: 0.0)
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            UIView.animate(withDuration: 0.5, animations: {
                
                toView.transform = CGAffineTransform.identity
                
            }) { (_) in
                
                transitionContext.completeTransition(true)
            }
        }else{
            
            guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)else{
                return
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                
                fromView.transform = CGAffineTransform(scaleX: 1.0,y: 0.00001)
                
            }) { (_) in
                
                transitionContext.completeTransition(true)
            }
        }
    }
    
    }





