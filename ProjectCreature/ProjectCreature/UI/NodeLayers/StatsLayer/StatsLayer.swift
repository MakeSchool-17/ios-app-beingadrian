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
    
    // MARK: - UI Properties
    
    var statisticsTitleLabel: SKLabelNode!
    
    var distanceTitleLabel: SKLabelNode!
    var distanceValueLabel: SKLabelNode!
    var distanceUnitLabel: SKLabelNode!

    var progressTitleLabel: SKLabelNode!
    var progressValueLabel: SKLabelNode!
    
    var stepCircleGroup: SKSpriteNode!
    var totalStepsTitleLabel: SKLabelNode!
    var totalStepsValueLabel: SKLabelNode!
    var dateLabel: SKLabelNode!
    
    var circleBack: CircleProgressBar!
    var circleFront: CircleProgressBar!
    
    
    // MARK: - Base methods
    
    init(size: CGSize) {
        
        let texture = SKTexture(imageNamed: "Background")
        super.init(texture: texture, color: UIColor(), size: size)
        
        self.userInteractionEnabled = true
        
        self.alpha = 0
        
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    // MARK: - Touch handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        
    }
    
    // MARK: - Transitions
    
    func transitionIn() {
        
        let fadeInAction = SKAction.fadeInWithDuration(0.35)
        self.runAction(fadeInAction)
        
    }

}
