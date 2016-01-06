//
//  LoadingLayer.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/5/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import SpriteKit


class LoadingLayer: SKSpriteNode {

    // MARK: - Properties
    
    
    
    // MARK: - Initialization 
    
    init(size: CGSize) {
        
        let color = UIColor.rgbaColor(r: 255, g: 255, b: 255, a: 1)
        
        super.init(texture: nil, color: color, size: size)
        
        self.anchorPoint = CGPointZero
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    // MARK: - Transitions
    
    func transitionOut() {
        
        let fadeOutAction = SKAction.fadeOutWithDuration(0.33)
        fadeOutAction.timingMode = .EaseOut
        
        self.runAction(fadeOutAction) {
            self.removeFromParent()
        }
        
    }
    
}

extension LoadingLayer {
    
    func setupUI() {
        
        
        
    }
    
}
