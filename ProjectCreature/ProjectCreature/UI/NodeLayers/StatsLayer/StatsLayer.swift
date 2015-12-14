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
    
    var histogramGroup: SKSpriteNode!
    var histogramBarsBack: SKSpriteNode!
    var histogramPointer: SKSpriteNode!
    var histogramBarsFront: [SKSpriteNode] = []
    
    var closeButton: SKSpriteNode!
    
    // MARK: - Base methods
    
    init(size: CGSize) {
        
        let texture = SKTexture(imageNamed: "Background")
        super.init(texture: texture, color: UIColor(), size: size)
        
        // initially disable user interaction to avoid touch conflicts during transition
        self.userInteractionEnabled = false
        
        self.alpha = 0
        
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    // MARK: - Touch handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.locationInNode(self)
        
        let touchedNode = self.nodeAtPoint(touchLocation)
        
        if touchedNode.isEqualToNode(closeButton) {
            self.transitionOut {
                guard let dashboardScene = self.parent as? DashboardScene else { return }
                dashboardScene.transitionIn {
                    dashboardScene.userInteractionEnabled = true
                    self.removeFromParent()
                }
            }
        }
        
    }
    
    // MARK: - Transitions
    
    typealias TransitionCallback = () -> Void
    
    func transitionIn(completion: TransitionCallback) {
        
        let fadeInAction = SKAction.fadeInWithDuration(0.35)
        self.runAction(fadeInAction, completion: completion)
        
    }
    
    func transitionOut(completion: TransitionCallback) {
        
        // disable user interaction to avoid touch conflicts
        self.userInteractionEnabled = false
        
        let fadeOutAction = SKAction.fadeOutWithDuration(0.15)
        
        self.runAction(fadeOutAction, completion: completion)
        
    }

}
