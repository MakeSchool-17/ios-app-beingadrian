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

    var disposeBag = DisposeBag()

    // MARK: - Base methods
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let view = view as? SKView else { return }
        let scene = DashboardScene(size: view.frame.size)
        scene.scaleMode = .Fill
        
        view.presentScene(scene)

    }
    
    override func viewDidAppear(animated: Bool) {
        
        // healthKit permission
        HKHelper().requestHealthKitAuthorization()
            .subscribeNext { success in
                print("> Request HealthKit authorization: \(success)")
            }
            .addDisposableTo(disposeBag)
        
    }
    
    override func prefersStatusBarHidden() -> Bool { return true }

}
