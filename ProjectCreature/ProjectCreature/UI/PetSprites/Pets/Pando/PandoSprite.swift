//
//  PandoSprite.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/7/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class PandoSprite: PetSprite {

    // MARK: - Initialization
    
    override init() {
        super.init()
        
        self.familyName = "Pando"
        self.bodySetup()
        self.observeState()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    // MARK: - Body setup
    
    override func bodySetup() {
        
        // body
        body = SKSpriteNode(imageNamed: familyName + " - Body")
        body.position.x = size.halfWidth
        body.position.y = size.halfHeight
        
        // head
        head = PetHead(familyName: familyName)
        head.anchorPoint = CGPoint(x: 0.5, y: 0)
        head.position = CGPoint(x: 0, y: 10)
        head.userInteractionEnabled = true
        
        // hands
        let hands = SKSpriteNode()
        hands.position = CGPoint(x: 0, y: 12)
        
        leftHand = SKSpriteNode(imageNamed: familyName + " - HandLeft")
        leftHand.anchorPoint = CGPoint(x: 1, y: 0.5)
        leftHand.position = CGPoint(x: -40, y: 0)
        hands.addChild(leftHand)
        
        rightHand = SKSpriteNode(imageNamed: familyName + " - HandRight")
        rightHand.anchorPoint = CGPoint(x: 0, y: 0.5)
        rightHand.position = CGPoint(x: 40, y: 0)
        hands.addChild(rightHand)
        
        // legs
        let legs = SKSpriteNode()
        legs.position = CGPoint(x: 0, y: -25)
        
        leftLeg = SKSpriteNode(imageNamed: familyName + " - LegLeft")
        leftLeg.position = CGPoint(x: -22, y: 0)
        legs.addChild(leftLeg)
        
        rightLeg = SKSpriteNode(imageNamed: familyName + " - LegRight")
        rightLeg.position = CGPoint(x: 22, y: 0)
        legs.addChild(rightLeg)
        
        body.addChild(head)
        body.addChild(hands)
        body.addChild(legs)
        self.addChild(body)
        
    }
    
    // MARK: - State observation
    
    override func observeState() {
        
        state
            .subscribeNext { state in
                switch state {
                case .Neutral:
                    self.neutral()
                case .Happy:
                    self.happy()
                case .Sad:
                    self.sad()
                case .Asleep:
                    self.asleep()
                case .Fainted:
                    self.fainted()
                }
            }
            .addDisposableTo(disposeBag)
        
    }

}
