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
    
    @IBOutlet weak var popUpView: UIView!
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        
        self.popUpView.userInteractionEnabled = false
        
        // add gesture recognizer for exit
        let tapGesture = UITapGestureRecognizer(target: self, action: "didTapBackgroundView:")
        self.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK: - Tap gesture actions
    
    func didTapBackgroundView(tapRecognizer: UITapGestureRecognizer) {
        
        let touchPoint = tapRecognizer.locationInView(self)
        
        if !popUpView.frame.contains(touchPoint) {
            self.animateOut()
        }
        
    }
    
    // MARK: - Animations
    
    func animateIn() {
        
        self.popUpView.transform = CGAffineTransformMakeScale(0, 0)
        self.alpha = 0
        
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: .CurveEaseOut,
            animations: { () -> Void in
                self.alpha = 1
                self.popUpView.transform = CGAffineTransformMakeScale(1, 1)
            },
            completion: nil)
        
    }

    func animateOut() {
        
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: .CurveEaseIn,
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
