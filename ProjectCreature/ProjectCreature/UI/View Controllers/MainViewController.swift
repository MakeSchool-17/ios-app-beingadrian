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
        
        if let gameManager = loadDataFromLocal() {
            self.gameManager = gameManager
        } else {
            // simulate pet and user
            guard let testPet = Test().createTestPet() else { return }
            let testUser = Test().createTestUser()
            self.gameManager = GameManager.create(testUser, pet: testPet)
        }
        
        guard let gameManager = self.gameManager else { return }
        
        presentScene(withGameManager: gameManager)
    
    }
    
    /**
     * Tries to load data from local presistence. 
     * If there is no data stored locally, the method returns nil. 
     *
     * - returns: An optional tuple of User and Pet.
     */
    private func loadDataFromLocal() -> GameManager? {
        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        
//        let gameManagerData = defaults.objectForKey("GameManagerArchive") as? NSData
//        
//        if let gameManagerData = gameManagerData {
//            let gameManager = NSKeyedUnarchiver.unarchiveObjectWithData(gameManagerData) as! GameManager
//            return gameManager
//        }
        
        return nil
        
    }
    
    /**
     * Presents the SKScene. 
     *
     * - parameter gameManager: An instance of a `GameManager`.
     */
    private func presentScene(withGameManager gameManager: GameManager) {
        
        guard let view = self.view as? SKView else { return }
        
        let scene = DashboardScene()
        scene.gameManager = gameManager
        scene.viewModel = DashboardViewModel(pet: gameManager.petManager.pet, user: gameManager.user)
        
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
