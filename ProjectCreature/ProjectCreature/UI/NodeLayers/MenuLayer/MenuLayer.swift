//
//  MenuLayer.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/7/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class MenuLayer: SKSpriteNode {
    
    // MARK: - UI Properties
    
    var menuGroup: SKSpriteNode!
    
    var awardsButton: SKButtonSprite!
    var awardsIcon: SKSpriteNode!
    var awardsLabel: SKLabelNode!
    
    var leaderboardButton: SKButtonSprite!
    var leaderboardIcon: SKSpriteNode!
    var leaderboardLabel: SKLabelNode!
    
    var storeButton: SKButtonSprite!
    var storeIcon: SKSpriteNode!
    var storeLabel: SKLabelNode!
    
    var settingsButton: SKSpriteNode!
    var settingsIcon: SKSpriteNode!
    var settingsLabel: SKLabelNode!
    
    // MARK: - Base methods
    
    init(size: CGSize) {
        
        let color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.99)
        super.init(texture: nil, color: color, size: size)
        
        self.userInteractionEnabled = true
        
        self.alpha = 0
        
        setupUI()
    
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    // MARK: - Touch handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.locationInNode(self)
        
        let touchedNode = self.nodeAtPoint(touchLocation)
        
        if touchedNode.isEqualToNode(awardsButton) {
            presentAwardsScene()
        } else if touchedNode.isEqualToNode(leaderboardButton) {
            print("> Leaderboard")
        } else if touchedNode.isEqualToNode(storeButton) {
            print("> Store")
        } else if touchedNode.isEqualToNode(settingsButton) {
            print("> Settings")
        } else {
            transitionOut()
        }

    }
    
    // MARK: - Transitions 
    
    func transitionIn() {
        
        let fadeInAction = SKAction.fadeInWithDuration(0.15)
        fadeInAction.timingMode = .EaseOut
        
        self.menuGroup.setScale(0)
        let popAction = SKAction.scaleTo(1,
            duration: 1,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0)
        
        let transitionInAction = SKAction.runBlock {
            self.runAction(fadeInAction)
            self.menuGroup.runAction(popAction)
        }
        
        self.runAction(transitionInAction)
        
    }

    private func transitionOut() {
        
        let fadeOutAction = SKAction.fadeOutWithDuration(0.13)
        fadeOutAction.timingMode = .EaseOut
        
        let scaleDownAction = SKAction.scaleTo(0, duration: 0.13)
        scaleDownAction.timingMode = .EaseIn
        
        let actionBlock = SKAction.runBlock {
            self.runAction(fadeOutAction)
            self.menuGroup.runAction(scaleDownAction) {
                self.removeFromParent()
            }
        }
        
        self.runAction(actionBlock)
        
    }
    
    // MARK: - Scene destinations
    
    private func presentAwardsScene() {
        
        guard let scene = self.scene as? DashboardScene else { return }
        guard let view = scene.view else { return }
        
        view.window?.rootViewController?.performSegueWithIdentifier("awardsSegue", sender: self)
        
    }
    
}

