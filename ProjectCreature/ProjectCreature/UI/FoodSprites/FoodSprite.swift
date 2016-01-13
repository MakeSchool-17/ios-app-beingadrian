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
    
    var initialPosition: CGPoint?
    var onTouchRelease = PublishSubject<CGPoint>()
    
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
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let parent = self.parent else{ return }
        guard let touchPosition = touches.first?.locationInNode(parent) else { return }

        self.position = touchPosition
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let parent = self.parent else { return }
        guard let touchPosition = touches.first?.locationInNode(parent) else { return }
        
        onTouchRelease.onNext(touchPosition)
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
        guard let initialPosition = self.initialPosition else { return }
        
        // returns the food sprite's position to its initial position
        self.position = initialPosition
        
    }
    
    func returnToOriginalPosition() {
        
        guard let initialPosition = self.initialPosition else { return }
        
        let duration: NSTimeInterval = 0.7
        let returnAction = SKAction.moveTo(initialPosition, duration: duration)
        returnAction.timingFunction = { t in
            // cubic ease out
            return 1 - pow(1 - t / Float(duration), 5)
        }
        
        self.runAction(returnAction)
        
    }
    
    // MARK: - Animations
    
    func performEatenAction(completion: () -> Void) {
        
        let scaleUpAction = SKAction.scaleTo(1.5, duration: 0.10)
        scaleUpAction.timingMode = .EaseOut
        
        let scaleDownAction = SKAction.scaleTo(0, duration: 0.27)
        scaleDownAction.timingMode = .EaseIn
        
        let sequence = SKAction.sequence([scaleUpAction, scaleDownAction])
        
        self.runAction(sequence) {
            self.removeFromParent()
            completion()
        }
        
    }
    
}
