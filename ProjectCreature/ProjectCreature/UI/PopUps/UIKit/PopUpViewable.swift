//
//  PopUpView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/5/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation
import UIKit


protocol PopUpViewable: class {
    
    /**
     * Called when a pop up viewable finishes in transition.
     */
    func didFinishTransitionIn()
    
}

extension PopUpViewable {
    
    // MARK: - Setup
    
    func setup() {
        
        guard let selfAsView = self as? UIView else { return }
        
        selfAsView.layer.zPosition = 1
        
        selfAsView.backgroundColor = UIColor.whiteColor()
        selfAsView.layer.cornerRadius = 23
        selfAsView.layer.borderWidth = 6.5
        selfAsView.layer.borderColor = UIColor.rgbaColor(
            r: 115, g: 115, b: 115, a: 1).CGColor
        
    }
    
    // MARK: - Transitions
    
    /**
     * Shows the pop up on a given view.
     *
     * - parameter view: A view.
     * - parameter animated: Determines whether to execute an animated transition.
     */
    func showInView(view: UIView, animated: Bool) {
        
        guard let selfAsView = self as? UIView else { return }
        
        view.addSubview(selfAsView)
        self.centerInView(view)
        
        if animated {
            self.transitionIn()
        }
        
    }
    
    func centerInView(view: UIView) {
        
        guard let selfAsView = self as? UIView else { return }
        
        selfAsView.center = view.center
        
    }
    
    func transitionIn() {
        
        guard let selfAsView = self as? UIView else { return }
        
        selfAsView.transform = CGAffineTransformMakeScale(0, 0)
        
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: [.CurveEaseIn, .AllowUserInteraction],
            animations: { () -> Void in
                selfAsView.transform = CGAffineTransformMakeScale(1, 1)
            },
            completion: { finished in
                if finished { self.didFinishTransitionIn() }
        })
        
    }
    
    func transitionOut() {
        
        guard let selfAsView = self as? UIView else { return }
        
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: [.CurveEaseIn, .AllowUserInteraction],
            animations: { () -> Void in
                selfAsView.transform = CGAffineTransformMakeScale(0, 0)
            },
            completion: { finished in
                guard finished else { return }
                selfAsView.removeFromSuperview()
        })
        
    }
    
}

