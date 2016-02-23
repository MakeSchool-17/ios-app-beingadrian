//
//  SimpleMessagePopUpView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/6/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit

/**
 * Simple pop up containing a text message.
 * Auto-dismisses itself after 2 seconds.
 */
class SimpleMessagePopUpView: UIView {

    // MARK: - Properties
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var text: String = "" {
        didSet {
            self.messageLabel.text = text
        }
    }
    
    /**
     * The duration of the delay before the pop up dismisses itself.
     * Default is `1` second. Use `-1` to disable auto-dismiss.
     */
    var delay: Double = 1
    
    override func awakeFromNib() {
        
        setup()
        
    }
    
    func onTimerFinish() {
        
        // exit
        guard let superview = self.superview as? PopUpBaseView else { return }
        superview.transitionOut()
        
    }

}

extension SimpleMessagePopUpView: PopUpViewable {
    
    func didFinishTransitionIn() {
        
        guard (self.delay >= 0) else { return }
        
        // start timer
        let delay = self.delay * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            self.onTimerFinish()
        }
        
    }
    
}
