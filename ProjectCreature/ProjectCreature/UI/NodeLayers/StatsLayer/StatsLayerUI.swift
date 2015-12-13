//
//  StatsLayerUI.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/7/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit


extension StatsLayer {
    
    func setupUI() {
        
        self.anchorPoint = CGPointZero
        self.position = CGPointZero
        self.zPosition = 6
        
        func createLabelNode(
            text: String,
            fontSize: CGFloat,
            fontName: String = "Avenir-Light",
            horizontalAlign: SKLabelHorizontalAlignmentMode = .Center,
            verticalAlign: SKLabelVerticalAlignmentMode = .Baseline) -> SKLabelNode {
            
            let labelNode = SKLabelNode(text: text)
                
            labelNode.horizontalAlignmentMode = horizontalAlign
            labelNode.verticalAlignmentMode = verticalAlign
                
            labelNode.fontSize = fontSize
            labelNode.fontName = fontName
            labelNode.fontColor = UIColor(
                red: 141/255,
                green: 142/255,
                blue: 145/255,
                alpha: 1)
            
            return labelNode
            
        }
        
        // MARK: Statistics title
        
        statisticsTitleLabel = createLabelNode("/statistics",
            fontSize: 18,
            fontName: "Avenir-HeavyOblique")
        statisticsTitleLabel.position.x = self.size.halfWidth
        statisticsTitleLabel.position.y = self.size.height - 40
        self.addChild(statisticsTitleLabel)
        
        // MARK: Distance
        
        distanceTitleLabel = createLabelNode("DISTANCE",
            fontSize: 13,
            horizontalAlign: .Left,
            verticalAlign: .Top)
        distanceTitleLabel.position.x = 27
        distanceTitleLabel.position.y = self.size.height - 55
        self.addChild(distanceTitleLabel)
        
        // valueLabel is child of titleLabel
        distanceValueLabel = createLabelNode("0.0",
            fontSize: 42,
            horizontalAlign: .Left,
            verticalAlign: .Baseline)
        distanceValueLabel.position.x = 0
        distanceValueLabel.position.y = -50
        distanceTitleLabel.addChild(distanceValueLabel)
        
        // unitLabel is child of valueLabel
        distanceUnitLabel = createLabelNode("km",
            fontSize: 16,
            horizontalAlign: .Left,
            verticalAlign: .Baseline)
        distanceUnitLabel.position.x = distanceValueLabel.frame.maxX + 3
        distanceUnitLabel.position.y = 0
        distanceValueLabel.addChild(distanceUnitLabel)
        
        // MARK: Progress
        
        progressTitleLabel = createLabelNode("PROGRESS",
            fontSize: 13,
            horizontalAlign: .Right,
            verticalAlign: .Top)
        progressTitleLabel.position.x = self.frame.maxX - 27
        progressTitleLabel.position.y = self.size.height - 55
        self.addChild(progressTitleLabel)
        
        progressValueLabel = createLabelNode("0%",
            fontSize: 42,
            horizontalAlign: .Right,
            verticalAlign: .Baseline)
        progressValueLabel.position.x = 0
        progressValueLabel.position.y = -50
        progressTitleLabel.addChild(progressValueLabel)
        
        // MARK: Total steps
        
        stepCircleGroup = SKSpriteNode()
        stepCircleGroup.position = CGPoint(
            x: self.frame.midX,
            y: self.frame.midY + 50)
        self.addChild(stepCircleGroup)
        
        totalStepsTitleLabel = createLabelNode("TOTAL STEPS",
            fontSize: 13,
            horizontalAlign: .Center,
            verticalAlign: .Baseline)
        totalStepsTitleLabel.position.x = 0
        totalStepsTitleLabel.position.y = 20
        stepCircleGroup.addChild(totalStepsTitleLabel)
        
        totalStepsValueLabel = createLabelNode("10,000",
            fontSize: 42,
            horizontalAlign: .Center,
            verticalAlign: .Baseline)
        totalStepsValueLabel.position.x = 0
        totalStepsValueLabel.position.y = -20
        stepCircleGroup.addChild(totalStepsValueLabel)
        
        dateLabel = createLabelNode("December 10, 2015",
            fontSize: 12,
            horizontalAlign: .Center,
            verticalAlign: .Baseline)
        dateLabel.position.x = 0
        dateLabel.position.y = -42
        stepCircleGroup.addChild(dateLabel)
    
        // MARK: Circle
        
        // circle magic numbers
        let radius: CGFloat = 115 - (37 / 4)
        let width: CGFloat = 37 / 2
        let greyColor = UIColor.rgbaColor(r: 216, g: 216, b: 216, a: 1)
        let tealColor = UIColor.rgbaColor(r: 71, g: 216, b: 178, a: 1)
        
        // circle back
        circleBack = CircleProgressBar(
            radius: radius,
            width: width,
            color: greyColor)
        circleBack.position = CGPointZero
        circleBack.path = circleBack.createBezierPath(radius, progress: 1).CGPath
        stepCircleGroup.addChild(circleBack)
        
        // circle front
        circleFront = CircleProgressBar(
            radius: radius,
            width: width,
            color: tealColor)
        circleFront.position =  CGPointZero
        circleFront.animateToProgress(1, progress: 0.75)
        
        stepCircleGroup.addChild(circleFront)
        
        // MARK: Bar graph
        
        // base group
        histogramGroup = SKSpriteNode(imageNamed: "Histogram - base")
        histogramGroup.position.x = self.frame.midX
        histogramGroup.position.y = self.frame.minY + 82
        self.addChild(histogramGroup)
        
        // bars back
        histogramBarsBack = SKSpriteNode(imageNamed: "Histogram - bars - back")
        histogramBarsBack.anchorPoint = CGPoint(x: 0.5, y: 0)
        histogramBarsBack.position.x = 0
        histogramBarsBack.position.y = 10
        histogramGroup.addChild(histogramBarsBack)
        
        // pointer 
        histogramPointer = SKSpriteNode(imageNamed: "Histogram - pointer")
        histogramPointer.position.x = histogramBarsBack.frame.midX
        histogramPointer.position.y = histogramBarsBack.size.height + 20
        histogramGroup.addChild(histogramPointer)
        
        // bars front 
        for i in 0...6 {
            let frontBar = SKSpriteNode(imageNamed: "Histogram - bar - front")
            frontBar.anchorPoint = CGPointZero
            frontBar.position.x = CGFloat(i) * (17 + frontBar.size.width) - histogramBarsBack.size.halfWidth
            frontBar.position.y = 0
            frontBar.size.height = 0
            
            histogramBarsBack.addChild(frontBar)
            histogramBarsFront.append(frontBar)
        }
        
        // MARK: Close button
        
        closeButton = SKSpriteNode(imageNamed: "Close button")
        closeButton.position.x = self.frame.maxX - (15 + closeButton.size.halfWidth)
        closeButton.position.y = self.frame.minY + (15 + closeButton.size.halfHeight)
        self.addChild(closeButton)
        
    }
    
}