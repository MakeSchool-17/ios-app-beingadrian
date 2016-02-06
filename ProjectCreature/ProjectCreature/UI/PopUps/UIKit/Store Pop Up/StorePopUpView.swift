 //
//  StorePopUpView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/5/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class StorePopUpView: UIView {

    // MARK: - Properties
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        
        setup()
        
    }
    
    // MARK: - Button actions
    
    func setupButtonActions() {
        
        self.confirmButton.addTarget(self, action: "onConfirmButtonTap", forControlEvents: .TouchUpInside)
        self.cancelButton.addTarget(self, action: "onCancelButtonTap", forControlEvents: .TouchUpInside)
        
    }
    
    func onConfirmButtonTap() {
        
        print("Heck yeah")
    }
    
    func onCancelButtonTap() {
        
        guard let superview = self.superview as? PopUpView else { return }
        superview.transitionOut()
        
    }

}

extension StorePopUpView: PopUpViewable {
    
    func didFinishTransition() {
        
        setupButtonActions()
        
    }
    
}

extension StorePopUpView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        let touchPoint = touch.locationInView(self.superview)
    
        if self.frame.contains(touchPoint) {
            return false
        }
        
        return true
        
    }
    
}
