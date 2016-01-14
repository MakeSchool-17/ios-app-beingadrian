//
//  ProgressReportPopUp.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/11/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import SpriteKit


class ProgressReportPopUp: PopUpLayer {

    // MARK: - UI Properties
    
    var roundedRect: SKShapeNode!
    var earningLabel: SKLabelNode!
    var chargeBar: BarHorizontal!
    
    // MARK: - Initialization
    
    override init(size: CGSize, newSteps: Int, petName: String) {
        super.init(size: size, newSteps: newSteps, petName: petName)
        
        setupUI()
        
        earningLabel.text = "You've earned \(newSteps) charges!"
        
        self.userInteractionEnabled = true
        
    }
    
    override func setupUI() {
        
        // roundedRect
        self.roundedRect = createRoundedRectangle(230, height: 117)
        roundedRect.position = CGPoint(x: self.frame.midX, y: self.frame.midY)

        // progress report label
        let progressReportLabel = SKLabelNode(text: "PROGRESS REPORT")
        progressReportLabel.fontName = "Avenir-HeavyOblique"
        progressReportLabel.fontSize = 20
        progressReportLabel.fontColor = UIColor.rgbaColor(
            r: 88, g: 88, b: 88, a: 1)
        progressReportLabel.position = CGPoint(
            x: 0, y: 20)
        
        // earningLabel
        earningLabel = SKLabelNode()
        earningLabel.fontName = "Avenir-Book"
        earningLabel.fontSize = 12
        earningLabel.fontColor = UIColor.rgbaColor(
            r: 88, g: 88, b: 88, a: 1)
        earningLabel.position = CGPoint(x: 0, y: 0)
        
        // charge bar
        let chargeBarGroup = SKSpriteNode()
        chargeBarGroup.position = CGPoint(x: 5, y: 0)

        let chargeBarBack = SKSpriteNode(imageNamed: "Charge bar - back")
        chargeBarBack.position = CGPoint(x: 0, y: -25)
        
        let chargeBarMask = SKSpriteNode(imageNamed: "Charge bar - back")
        chargeBarMask.position.x = chargeBarBack.size.halfWidth
        chargeBarMask.position.y = -(chargeBarBack.size.halfHeight)
        
        let chargeBarCrop = SKCropNode()
        chargeBarCrop.maskNode = chargeBarMask
        chargeBarCrop.position.x = -chargeBarMask.frame.halfWidth
        chargeBarCrop.position.y = chargeBarMask.frame.halfHeight
        
        chargeBar = BarHorizontal(imageNamed: "Charge bar - front")
        chargeBar.anchorPoint = CGPoint(x: 0, y: 1)
        
        chargeBarCrop.addChild(chargeBar)
        chargeBarBack.addChild(chargeBarCrop)
        chargeBarGroup.addChild(chargeBarBack)
        
        let chargeIcon = SKSpriteNode(imageNamed: "Energy icon")
        chargeIcon.position.x = chargeBarBack.frame.minX - 10
        chargeBarBack.addChild(chargeIcon)
        
        self.addChild(roundedRect)
        roundedRect.addChild(progressReportLabel)
        roundedRect.addChild(earningLabel)
        roundedRect.addChild(chargeBarGroup)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    // MARK: - Touch handling 
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touchPosition = touches.first?.locationInNode(self) else { return }
        
        let touchedNode = self.nodeAtPoint(touchPosition)
        
        if !touchedNode.isEqualToNode(roundedRect) {
            self.transitionOut()
        }
        
    }
    
    // MARK: - Bar
    
    private func animateBar() {
        
        chargeBar.xScale = 0
        
        let scaleAction = SKAction.scaleXTo(1, duration: 1)
        scaleAction.timingMode = .EaseOut
        
        chargeBar.runAction(scaleAction)
        
    }
    
    // MARK: - Transitions
    
    override func transitionIn() {
        
        // set initial UI state
        self.alpha = 0
        self.roundedRect.setScale(0)
        
        let fadeInAction = SKAction.fadeInWithDuration(0.15)
        fadeInAction.timingMode = .EaseOut
        
        let popInAction = SKAction.scaleTo(
            1,
            duration: 1,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0)
        
        let transitionInAction = SKAction.runBlock {
            self.runAction(fadeInAction)
            self.roundedRect.runAction(popInAction)
            self.animateBar()
        }
        
        self.runAction(transitionInAction)
        
    }
    
    override func transitionOut() {
        
        let fadeOutAction = SKAction.fadeOutWithDuration(0.13)
        fadeOutAction.timingMode = .EaseOut
        
        let scaleDownAction = SKAction.scaleTo(0, duration: 0.13)
        scaleDownAction.timingMode = .EaseIn
        
        let transitionOutAction = SKAction.runBlock {
            self.runAction(fadeOutAction)
            self.roundedRect.runAction(scaleDownAction) {
                self.removeFromParent()
            }
        }
        
        self.runAction(transitionOutAction)
        
    }
    
}
