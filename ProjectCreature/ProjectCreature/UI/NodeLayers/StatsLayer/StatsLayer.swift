//
//  StatsLayer.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/7/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class StatsLayer: SKSpriteNode {
    
    init(size: CGSize, scene: SKScene) {
        super.init(texture: nil, color: UIColor(), size: size)

        setupUI()
        
        let fadeInAction = SKAction.fadeInWithDuration(0.35)
        self.runAction(fadeInAction)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    func transitionIn() {
        
        // insert code here
        
    }

}
