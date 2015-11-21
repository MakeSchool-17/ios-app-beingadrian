//
//  DashboardScene.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import PromiseKit


class DashboardScene: SKScene {
    
    // MARK: - Properties
    
    weak var label: SKLabelNode!
    weak var stepCountLabel: SKLabelNode!
    
    let healthHelper = HKHelper()
    let parseHelper = ParseHelper()
    
    
    // MARK: - Base methods
    
    override func didMoveToView(view: SKView) {
        
        label = self.childNodeWithName("label") as! SKLabelNode
        stepCountLabel = self.childNodeWithName("stepCountLabel") as! SKLabelNode
        
        label.position = CGPoint(x: frame.midX, y: frame.midY + 30)
        stepCountLabel.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        
        let calendar = NSCalendar.currentCalendar()
        let twoDaysAgo = calendar.dateByAddingUnit(.Day, value: -2, toDate: NSDate(), options: [])
        let twoDaysAgoInterval = twoDaysAgo!.timeIntervalSince1970
        
        firstly {
            healthHelper.queryTotalStepCount(sinceTimeInterval: twoDaysAgoInterval)
        }.then { (stepCount) in
            self.stepCountLabel.text = "\(stepCount)"
        }.error { (error) in
            print(error)
        }
        
    }
    
}
