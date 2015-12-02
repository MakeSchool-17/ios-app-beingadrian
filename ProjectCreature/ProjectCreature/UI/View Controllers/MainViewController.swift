//
//  MainViewController.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import SpriteKit
import RxSwift


class MainViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    // MARK: - Base methods
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let view = self.view as? SKView else { return }
        guard let dashboardScene = SKScene(fileNamed: "DashboardScene") else { return }
        dashboardScene.scaleMode = .Fill
        view.presentScene(dashboardScene)

    }
    
    override func viewDidAppear(animated: Bool) {
        
        // healthKit permission
//        HKHelper().requestHealthKitAuthorization()
//            .subscribeNext { success in
//                print("Request HealthKit authorization: \(success)")
//            }
//            .addDisposableTo(disposeBag)
        
    }
    
    override func prefersStatusBarHidden() -> Bool { return true }

}
