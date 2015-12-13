//
//  MenuButton.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/3/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import SpriteKit


class MenuButton: NavigationButton {
    
    override func performFunction() {

        guard let dashboardScene = self.parent as? DashboardScene else { return }
        
        dashboardScene.pushMenuLayer()
        
    }

}
