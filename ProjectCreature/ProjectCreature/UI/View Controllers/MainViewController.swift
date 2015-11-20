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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let view = self.view as? SKView else { return }
        guard let dashboardScene = SKScene(fileNamed: "DashboardScene") else { return }
        dashboardScene.scaleMode = .AspectFill
        view.presentScene(dashboardScene)

    }
    
    override func viewDidAppear(animated: Bool) {
        
        // healthKit permission
        HKHelper().requestHealthKitAuthorization().then {
            (success) in
            print(success)
        }.error {
            (error) in
            print(error)
        }
        
    }
    
    override func prefersStatusBarHidden() -> Bool { return true }

}
