//
//  PandoModel.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/24/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class PandoModel: SKSpriteNode {

    private var disposeBag = DisposeBag()
    
    var action = ActionManager()
    
    // MARK: - Properties
    
    enum State: String {
        case Neutral = "Neutral"
        case Happy = "Happy"
        case Sad = "Sad"
        case Asleep = "Asleep"
        case Fainted = "Fainted"
    }
    
    var state: Variable<State> = Variable(.Neutral)
    
    // MARK: - Body Properties
    
    var head: CreatureHead!
    
    var body: SKSpriteNode!
    
    var leftHand: SKSpriteNode!
    var rightHand: SKSpriteNode!
    
    var leftLeg: SKSpriteNode!
    var rightLeg: SKSpriteNode!
    
    // MARK: - Initialization
    
    init() {
        super.init(texture: nil, color: UIColor(), size: CGSizeZero)

        bodySetup()
        
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
    
    private func bodySetup() {

        // body
        body = SKSpriteNode(imageNamed: "Body")
        body.position.x = size.halfWidth
        body.position.y = size.halfHeight
        
        // head
        head = CreatureHead(imageNamed: "Head-Neutral")
        head.anchorPoint = CGPoint(x: 0.5, y: 0)
        head.position = CGPoint(x: 0, y: 10)
        head.userInteractionEnabled = true
    
        // hands
        let hands = SKSpriteNode()
        hands.position = CGPoint(x: 0, y: 12)
        
        leftHand = SKSpriteNode(imageNamed: "Hand-Left")
        leftHand.anchorPoint = CGPoint(x: 1, y: 0.5)
        leftHand.position = CGPoint(x: -40, y: 0)
        hands.addChild(leftHand)
        
        rightHand = SKSpriteNode(imageNamed: "Hand-Right")
        rightHand.anchorPoint = CGPoint(x: 0, y: 0.5)
        rightHand.position = CGPoint(x: 40, y: 0)
        hands.addChild(rightHand)
        
        // legs
        let legs = SKSpriteNode()
        legs.position = CGPoint(x: 0, y: -25)
        
        leftLeg = SKSpriteNode(imageNamed: "Leg-Left")
        leftLeg.position = CGPoint(x: -22, y: 0)
        legs.addChild(leftLeg)
        
        rightLeg = SKSpriteNode(imageNamed: "Leg-Right")
        rightLeg.position = CGPoint(x: 22, y: 0)
        legs.addChild(rightLeg)
        
        body.addChild(head)
        body.addChild(hands)
        body.addChild(legs)
        self.addChild(body)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }

}
