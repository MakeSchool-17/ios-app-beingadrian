//
//  MessagePopUpView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/6/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class MessagePopUpView: UIView {

    // MARK: - Properties
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okayButton: UIButton!
    
    var text: String = "" {
        didSet {
            self.messageLabel.text = text
        }
    }
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        
        setup()
        
    }
    
    // MARK: - Button actions
    
    private func setupButtonActions() {
        
        self.okayButton.addTarget(self, action: "onOkayButtonTap", forControlEvents: .TouchUpInside)
        
    }
    
    func onOkayButtonTap() {
        
        // exit
        guard let superview = self.superview as? PopUpBaseView else { return }
        superview.transitionOut()
        
    }

}

extension MessagePopUpView: PopUpViewable {
    
    func didFinishTransitionIn() {
        
        setupButtonActions()
        
    }
    
}
