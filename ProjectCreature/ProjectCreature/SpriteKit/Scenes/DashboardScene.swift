//
//  DashboardScene.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit

class DashboardScene: SKScene {
    
    // MARK: - Properties
    
    weak var label: SKLabelNode!
    weak var stepCountLabel: SKLabelNode!
    
    let healthHelper = HKHelper()
    
    
    // MARK: - Base methods
    
    override func didMoveToView(view: SKView) {
        
        label = self.childNodeWithName("label") as! SKLabelNode
        stepCountLabel = self.childNodeWithName("stepCountLabel") as! SKLabelNode
        
        label.position = CGPoint(x: frame.midX, y: frame.midY + 30)
        stepCountLabel.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        
        // healthkit test 
        let calendar = NSCalendar.currentCalendar()
        let yesterady = calendar.dateByAddingUnit(.Hour, value: -1, toDate: NSDate(), options: [])
        let interval = yesterady?.timeIntervalSince1970
        
        
        healthHelper.queryTotalStepCount(sinceTimeInterval: interval!) {
            (totalStepCount, error) in
            
            print(totalStepCount)
        }

    }
    
}
