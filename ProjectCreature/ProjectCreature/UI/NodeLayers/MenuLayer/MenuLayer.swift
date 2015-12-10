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
    
    var menuLine: SKSpriteNode!
    
    var trophyIcon: SKSpriteNode!
    var leaderBoardIcon: SKSpriteNode!
    var settingsIcon: SKSpriteNode!
    
    // MARK: - Base methods
    
    init(size: CGSize, scene: SKScene) {
        super.init(texture: nil, color: UIColor(), size: size)
        
        setupUI(parent: scene)
        
        self.alpha = 0
        
        createEffectNode(fromScene: scene)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Transitions 
    
    func transitionIn() {
        
        let fadeInAction = SKAction.fadeInWithDuration(0.35)
        fadeInAction.timingMode = .EaseOut
        self.runAction(fadeInAction) {
            self.menuLine.setScale(0)
            let popAction = SKAction.scaleTo(1,
                duration: 2,
                delay: 0,
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 0)
            self.menuLine.runAction(popAction)
        }
        
    }

    func transitionOut() {
        
        let fadeOutAction = SKAction.fadeOutWithDuration(0.35)
        fadeOutAction.timingMode = .EaseOut
        self.runAction(fadeOutAction)
        
    }
    
    /**
        Creates an blur effect node and adds it to the Menu Layer Node.
     
        - parameter fromScene scene: SKScene
    */
    func createEffectNode(fromScene scene: SKScene) {

        guard let view = scene.view else { return }
        
        // create blur texture
        guard let texture = view.textureFromNode(scene) else { return }
        texture.filteringMode = .Nearest
        
        guard let blurFilter = CIFilter(
            name: "CIGaussianBlur",
            withInputParameters: ["inputRadius": 15.0])
            else { return }
        
        let blurTexture = texture.textureByApplyingCIFilter(blurFilter)
        
        // create blur node
        let blurNode = SKSpriteNode(texture: blurTexture)
        blurNode.zPosition = 6
        blurNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        blurNode.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        
        // create white overlay node
        let color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
        let whiteNode = SKSpriteNode(color: color, size: self.frame.size)
        whiteNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        whiteNode.position = CGPointZero
        blurNode.addChild(whiteNode)
        
        self.addChild(blurNode)
        
    }
    
}

