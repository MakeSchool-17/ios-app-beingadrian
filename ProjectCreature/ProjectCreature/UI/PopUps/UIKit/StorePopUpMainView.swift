//
//  PopUpMainView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/1/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class StorePopUpMainView: PopUpMainView {
    
    // MARK: - Properties
    
    // insert properties here
    
    // MARK: - Setup
    
    override func setCustomPopUpView() {
        
        guard let popUpView = NSBundle.mainBundle()
            .loadNibNamed("StorePopUpView", owner: self, options: nil).first as? StorePopUpView
            else { return }
        
        self.popUpView = popUpView
        
    }
    
    override func popUpDidFinishAnimateIn() {
        
        
    
    }

}
