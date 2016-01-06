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

    private var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    var gameManager: GameManager?

    // MARK: - Base methods
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let view = view as? SKView else { return }
        
        // simulate creature and user
        guard let testCreature = Test().createTestCreature() else { return }
        let testUser = Test().createTestUser()
        
        // gameManager creation
        self.gameManager = GameManager(
            user: testUser,
            creature: testCreature)
        
        guard let gameManager = self.gameManager else { return }
        
        let scene = DashboardScene()
        scene.gameManager = gameManager
        scene.viewModel = DashboardViewModel(creature: gameManager.creature, user: gameManager.user)
        
        scene.scaleMode = .Fill
        
        view.presentScene(scene)
        
        // testing purposes
        view.showsFPS = true
        view.showsDrawCount = true
        view.showsQuadCount = true

    }
    
    override func viewDidAppear(animated: Bool) {
        
        HKHelper().requestHealthKitAuthorization()
            .subscribe(
                onNext: { (success) -> Void in
                    print("> HealthKit authorization: \(success)")
                },
                onError: { (error) -> Void in
                    print("> Error authorizing HealthKit: \(error)")
                },
                onCompleted: nil,
                onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
    
    // MARK: - Prepare for segue 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let viewController = segue.destinationViewController as? GameManagerHolder {
            
            viewController.gameManager = self.gameManager
            
        }
        
    }

}
