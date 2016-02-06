//
//  PopUpMainView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/1/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class PopUpMainView: UIView {
    
    // MARK: - Properties
    
    var popUpView: UIView!
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        
        setup()
        
        // add gesture recognizer for exit
        let tapGesture = UITapGestureRecognizer(target: self, action: "didTapBackgroundView:")
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
        
    }
    
    private func setup() {
        
        setCustomPopUpView()
        
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        
        self.popUpView.backgroundColor = UIColor.whiteColor()
        self.popUpView.layer.cornerRadius = 23
        self.popUpView.layer.borderWidth = 6.5
        self.popUpView.layer.borderColor = UIColor.rgbaColor(
            r: 115, g: 115, b: 115, a: 1).CGColor
        
    }
    
    func setCustomPopUpView() {
        
        
        
    }
    
    func popUpDidFinishAnimateIn() {
        
        
        
    }
    
    // MARK: - Tap gesture actions
    
    func didTapBackgroundView(gestureRecognizer: UIGestureRecognizer) {
        
        self.animateOut()
        
    }
    
    // MARK: - Animations
    
    func animateIn() {
        
        self.awakeFromNib()
        
        self.popUpView.transform = CGAffineTransformMakeScale(0, 0)
        self.alpha = 0
        
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: [.CurveEaseIn, .AllowUserInteraction],
            animations: { () -> Void in
                self.alpha = 1
                self.popUpView.transform = CGAffineTransformMakeScale(1, 1)
            },
            completion: { finished in
                if finished { self.popUpDidFinishAnimateIn() }
        })
        
    }
    
    func animateOut() {
        
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: [.CurveEaseIn, .AllowUserInteraction],
            animations: { () -> Void in
                self.popUpView.transform = CGAffineTransformMakeScale(0, 0)
                self.alpha = 0
            },
            completion: { finished in
                guard finished else { return }
                self.removeFromSuperview()
        })
        
    }
    
}

extension PopUpMainView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if self.popUpView.superview != nil {
            if touch.view!.isDescendantOfView(self.popUpView) {
                return false
            }
        }
        
        let touchPoint = touch.locationInView(self)
        
        if popUpView.frame.contains(touchPoint) {
            return false
        } else {
            return true
        }
        
    }
    
}
