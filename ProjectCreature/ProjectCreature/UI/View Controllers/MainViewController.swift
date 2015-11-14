//
//  MainViewController.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import SpriteKit


class MainViewController: UIViewController {

    
    // MARK: - Base methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as? SKView {
            
            let dashboardScene = SKScene(fileNamed: "DashboardScene")
            dashboardScene?.scaleMode = .AspectFill
            view.presentScene(dashboardScene)
            
        }
        
    }
    
    override func prefersStatusBarHidden() -> Bool { return true }

}
