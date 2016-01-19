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
        
        presentInitialScene()

    }
    
    private func presentInitialScene() {
    
        guard let view = view as? SKView else { return }
        
        // simulate pet and user
        guard let testPet = Test().createTestPet() else { return }
        let testUser = Test().createTestUser()
        
        
        
        // gameManager creation
        self.gameManager = GameManager(
            user: testUser,
            pet: testPet)
        
        guard let gameManager = self.gameManager else { return }
        
        let scene = DashboardScene()
        scene.gameManager = gameManager
        scene.viewModel = DashboardViewModel(pet: gameManager.pet, user: gameManager.user)
        
        scene.size = CGSize(width: 320, height: 568)
        scene.scaleMode = .Fill
        
        view.presentScene(scene)
        
        // testing purposes
        let isTesting = true
        view.showsFPS = isTesting
        view.showsDrawCount = isTesting
        view.showsQuadCount = isTesting
    
    }
    
    // MARK: - Prepare for segue 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let viewController = segue.destinationViewController as? GameManagerHolder {
            
            viewController.gameManager = self.gameManager
            
        }
        
    }

}
