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
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var delegate: PopUpMainViewDelegate?
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        
        // add gesture recognizer for exit
        let tapGesture = UITapGestureRecognizer(target: self, action: "didTapBackgroundView:")
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
        
    }
    
    func popUpDidFinishAnimateIn() {
        
        setupButtonTargets()
    
    }
    
    // MARK: - Tap gesture actions
    
    func didTapBackgroundView(gestureRecognizer: UIGestureRecognizer) {
        
        self.animateOut()
        
    }
    
    func setupButtonTargets() {
        
        self.confirmButton.addTarget(self,
            action: "onConfirmButtonTap:", forControlEvents: .TouchUpInside)
        self.cancelButton.addTarget(self,
            action: "onCancelButtonTap:", forControlEvents: .TouchUpInside)
        
    }
    
    func onConfirmButtonTap(sender: UIButton) {
        
        delegate?.didTapConfirmButton()
        
    }
    
    func onCancelButtonTap(sender: UIButton) {
        
        delegate?.didTapCancelButton()
        
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
