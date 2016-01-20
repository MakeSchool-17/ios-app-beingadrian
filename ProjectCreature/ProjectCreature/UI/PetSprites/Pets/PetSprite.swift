//
//  PetSprite.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/7/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift

/**
 * An abstract class for pet sprites.
 */
class PetSprite: SKSpriteNode {
    
    var disposeBag = DisposeBag()
    
    var action = ActionManager()
    
    // MARK: - Properties
    
    var familyName: String!
    
    enum State: String {
        case Neutral = "neutral"
        case Happy = "happy"
        case Sad = "sad"
        case Asleep = "sleep"
        case Fainted = "fainted"
    }

    /**
     * An observable variable that represents the pet's mood and living state.
     */
    var state: Variable<State> = Variable(.Neutral)
    
    // MARK: - Body Properties
    
    var isBreathing: Bool = false
    
    var head: PetHead!
    var feedingArea: SKShapeNode!
    
    var body: SKSpriteNode!
    
    var leftHand: SKSpriteNode!
    var rightHand: SKSpriteNode!
    
    var leftLeg: SKSpriteNode!
    var rightLeg: SKSpriteNode!
    
    // MARK: - Initialization
    
    required init() {
        
        super.init(texture: nil, color: UIColor(), size: CGSizeZero)
        
        self.familyName = ""
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    func bodySetup() {}
    
    // MARK: - State observation
    
    /**
     * Observes the pet's `state` property and performs visual changes 
     * depending on the given state.
     */
    func observeState() {
        
        state
            .asObservable()
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
    
    // MARK: - Smiling
    
    /**
     * Changes the head texture of the pet temporarily to happy. 
     * 
     * - parameter duration: The duration for how long the smile will last.
     */
    func smileForDuration(duration: NSTimeInterval) {
        
        self.head.texture = createHeadTexture(forState: .Happy)
        self.head.eyes?.hidden = true
        
        head.isSmiling = true
        
        let delayAction = SKAction.waitForDuration(duration)
        
        let returnToInitialState = SKAction.runBlock {
            self.head.isSmiling = false

            self.head.texture = self.createHeadTexture(
                forState: self.state.value)
            self.head.eyes?.hidden = false
        }
        
        let sequence = SKAction.sequence([delayAction, returnToInitialState])
        
        head.runAction(sequence)
        
    }
    
    // MARK: - Feeding
    
    /**
     * Creates a feeding area.
     *
     * - parameter position: The position in which the feeding
     *                       area is going to be placed.
     */
    func createFeedingAreaWithPosition(position: CGPoint) {
        
        self.feedingArea = SKShapeNode(circleOfRadius: 60)
        feedingArea.zPosition = 51
        feedingArea.position = position
        feedingArea.hidden = true
        
        self.addChild(feedingArea)
        
    }
    
    // MARK: - Breathing
    
    /**
     * Perform normal breathing action for the pet.
     */
    func breatheNormally() {
        
        // prevents overlapping action if already breathing
        guard (!isBreathing) else { return }
        
        isBreathing = true
        
        head.runAction(action.breatheNormal)
        body.runAction(action.breatheNormal)
        leftHand.runAction(action.handLeftMoveNormal)
        rightHand.runAction(action.handRightMoveNormal)
        
    }
    
    /**
     * Helper function to create head depending on the `State`.
     *
     * - parameter state: The pet's state.
     */
    func createHeadTexture(forState state: State) -> SKTexture {
        
        return SKTexture(imageNamed: familyName + " - Head" + state.rawValue.capitalizedString)
        
    }
    
    // MARK: - State functions
    
    func neutral() {}
    
    func happy() {}
    
    func sad() {}
    
    func asleep() {}
    
    func fainted() {}
    
}
