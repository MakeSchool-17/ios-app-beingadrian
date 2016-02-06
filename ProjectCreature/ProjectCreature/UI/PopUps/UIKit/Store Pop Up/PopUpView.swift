//
//  PopUpBackgroundView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/6/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class PopUpView: UIView {
    
    // MARK: - Property
    
    var popUp: PopUpViewable?
    
    // MARK: - Awake from nib 
    
    override func awakeFromNib() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "transitionOut")
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK: - Transitions
    
    func transitionInView(view: UIView) {
        
        view.addSubview(self)
        
        self.frame.size = view.frame.size
        
        popUp?.showInView(self, animated: true)
        
        self.backgroundColor = UIColor.clearColor()
        
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: [.CurveEaseIn, .AllowUserInteraction],
            animations: { () -> Void in
                self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
            },
            completion: { finished in
                
            })
        
    }
    
    func transitionOut() {
        
        popUp?.transitionOut()
        
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: [.CurveEaseIn, .AllowUserInteraction],
            animations: { () -> Void in
                self.backgroundColor = UIColor.clearColor()
            },
            completion: { finished in
                self.removeFromSuperview()
            })
        
    }

}

extension PopUpView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        guard let popUp = self.popUp as? UIView else { return true }
        
        if touch.view!.isDescendantOfView(popUp) {
            return false
        }
        
        return true
        
    }
    
}
