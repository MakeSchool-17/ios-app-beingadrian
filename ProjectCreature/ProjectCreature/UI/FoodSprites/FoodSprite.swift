//
//  FoodSprite.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/7/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class FoodSprite: SKSpriteNode {
    
    // MARK: - Properties
    
    var food: Food
    
    var isTapped = PublishSubject<Bool>()
    
    // MARK: - Initialization
    
    init(food: Food) {
        
        self.food = food
        
        let texture = SKTexture(imageNamed: food.textureName)
        super.init(texture: texture, color: UIColor(), size: texture.size())
        
        self.userInteractionEnabled = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Touch handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.performTappedAction()
        
    }
    
    // MARK: - Animations
    
    private func performTappedAction() {
        
        let scaleUpAction = SKAction.scaleTo(1.5, duration: 0.10)
        scaleUpAction.timingMode = .EaseOut
        
        let scaleDownAction = SKAction.scaleTo(0, duration: 0.27)
        scaleDownAction.timingMode = .EaseIn
        
        let sequence = SKAction.sequence([scaleUpAction, scaleDownAction])
        
        self.runAction(sequence) {
            self.isTapped.onNext(true)
            self.removeFromParent()
        }
        
    }
    
}
