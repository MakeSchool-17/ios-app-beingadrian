//
//  CircleProgressBar.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/11/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//
//  SpriteKit progress timer inspired by: 
//  http://tonychamblee.com/2013/11/18/tcprogresstimer-a-spritekit-progress-timer/
//

import SpriteKit


/**
 An animatable circular progress bar.
 */
class CircleProgressBar: SKShapeNode {
    
    // MARK: - Properties
    
    var radius: CGFloat
    var width: CGFloat {
        didSet { self.lineWidth = width }
    }
    var color: UIColor {
        didSet { self.strokeColor = color }
    }

    var progress: CGFloat = 0
    
    // MARK: - Initialization
    
    init(radius: CGFloat, width: CGFloat, color: UIColor) {
        
        self.radius = radius
        self.width = width
        self.color = color
        
        super.init()
        
        // set original rotation (-45 degrees)
        self.zRotation = CGFloat(M_PI) / 2.0
        self.lineWidth = width
        self.strokeColor = color
        self.fillColor = UIColor.clearColor()
        self.path = createBezierPath(self.radius, progress: 0).CGPath
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    // MARK: - Bezier path creation
    
    func createBezierPath(radius: CGFloat, progress: CGFloat) -> UIBezierPath {
        
        let startAngle: CGFloat = 0
        
        // inverse progress
        let inverseProgress = 1 - progress
        
        let endAngle: CGFloat
        if (inverseProgress == 0) {
            endAngle = CGFloat(M_PI) * 2
        } else if (inverseProgress == 1) {
            endAngle = 0
        } else {
            endAngle = (CGFloat(M_PI) * 2 * inverseProgress)
        }
        
        let bezierPath = UIBezierPath(
            arcCenter: CGPointZero,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false)
        
        return bezierPath
        
    }
    
    // MARK: - Progress animations
    
    /**
    Animates the circular progress bar to the designated progress value.
    
    - parameter duration: The duration of the animation.
    - parameter progress: The value of the progress between 0.0 and 1.0
     */
    func animateToProgress(duration: NSTimeInterval, progress: Float) {
        
        let action = SKAction.customActionWithDuration(duration) {
            (node, elapsedTime) in
            
            var progressFraction = CGFloat(progress) * (elapsedTime / CGFloat(duration))
            
            if (progressFraction > 1) {
                self.lineWidth = self.lineWidth + 1
                progressFraction = 0.99999999
            }
            
            self.path = self.createBezierPath(self.radius, progress: progressFraction).CGPath
        }
        
        action.timingMode = .EaseOut
        
        self.runAction(action)
        
    }
    
}
