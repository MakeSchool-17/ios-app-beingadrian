 //
//  StorePopUpView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/5/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class StorePopUpView: UIView {

    // MARK: - UI Properties
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: StorePopUpViewDelegate?
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        
        setup()
        
    }
    
    // MARK: - Button actions
    
    private func setupButtonActions() {
        
        self.confirmButton.addTarget(self, action: "onConfirmButtonTap", forControlEvents: .TouchUpInside)
        self.cancelButton.addTarget(self, action: "onCancelButtonTap", forControlEvents: .TouchUpInside)
        
    }
    
    func onConfirmButtonTap() {
        
        delegate?.didTapConfirmButton()
        
        exit()
        
    }
    
    func onCancelButtonTap() {
        
        exit()
        
    }
    
    private func exit() {
        
        guard let superview = self.superview as? PopUpBaseView else { return }
        superview.transitionOut()
        
    }

}

extension StorePopUpView: PopUpViewable {
    
    func didFinishTransitionIn() {
        
        setupButtonActions()
        
    }
    
}
