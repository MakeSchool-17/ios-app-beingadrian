//
//  LoadingLayer.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/5/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import SpriteKit


class LoadingLayer: SKSpriteNode {
    
    var textLogo: SKSpriteNode!
    var circleProgress: CircleProgressBar!
    
    // MARK: - Initialization 
    
    init(size: CGSize) {
        
        let color = UIColor.rgbaColor(r: 255, g: 255, b: 255, a: 1)
        
        super.init(texture: nil, color: color, size: size)
        
        self.anchorPoint = CGPointZero
        
        setupUI()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        // text logo
        self.textLogo = SKSpriteNode(imageNamed: "Text-Logo")
        self.textLogo.position = CGPoint(x: frame.midX, y: frame.midY)
        self.textLogo.setScale(0.2)
        self.addChild(textLogo)
        
        // circle progress
        let radius: CGFloat = 115 - (37 / 4)
        let width: CGFloat = 37 / 3
        let tealColor = UIColor.rgbaColor(r: 71, g: 216, b: 178, a: 1)
        self.circleProgress = CircleProgressBar(radius: radius, width: width, color: tealColor)
        circleProgress.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(circleProgress)
        
    }
    
    // MARK: - Did finish loading
    
    func didFinishLoading() {
        
        let duration: NSTimeInterval = 1
        
        let completedAction = SKAction.runBlock {
            self.circleProgress.animateToProgress(duration, progress: 1)
        }
        
        let delay = SKAction.waitForDuration(duration)
        
        let sequence = SKAction.sequence([completedAction, delay])
        
        self.runAction(sequence) {
            let scaleUpAction = SKAction.scaleTo(4, duration: 0.42)
            scaleUpAction.timingMode = .EaseIn
            self.circleProgress.runAction(scaleUpAction)
            
            let scaleDownAction = SKAction.scaleTo(0, duration: 0.42)
            scaleDownAction.timingMode = .EaseIn
            let fadeOutAction = SKAction.fadeOutWithDuration(0.42)
            let groupAction = SKAction.group([scaleDownAction, fadeOutAction])
            self.textLogo.runAction(groupAction)
            
            self.transitionOut()
        }
        
    }
    
    // MARK: - Transitions
    
    private func transitionOut() {
        
        let fadeOutAction = SKAction.fadeOutWithDuration(0.42)
        fadeOutAction.timingMode = .EaseIn
        
        self.runAction(fadeOutAction) {
            self.removeFromParent()
        }
        
    }
    
}

