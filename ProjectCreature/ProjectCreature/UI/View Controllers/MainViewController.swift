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
        
        guard let view = view as? SKView else { return }
        guard let scene = SKScene(fileNamed: "DashboardScene") as? DashboardScene else { return }
        scene.scaleMode = .Fill
        
        // TEST: initial creature creation
        let creature = Creature()
        creature.name = "Rob"
        creature.family = "some family"
        creature.hp = 100
        creature.hpMax = 200
        creature.owner = PFUser.currentUser()!
        
        scene.viewModel = DashboardViewModel(creature: creature)
        
        view.presentScene(scene)

    }
    
    override func viewDidAppear(animated: Bool) {
        
        // healthKit permission
        HKHelper().requestHealthKitAuthorization()
            .subscribeNext { success in
                print("Request HealthKit authorization: \(success)")
            }
            .addDisposableTo(disposeBag)
        
    }
    
    override func prefersStatusBarHidden() -> Bool { return true }

}
