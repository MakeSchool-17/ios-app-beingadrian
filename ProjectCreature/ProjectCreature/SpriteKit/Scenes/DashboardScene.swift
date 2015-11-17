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
        
        // test healthkit helper functionlity
        let calendar = NSCalendar.currentCalendar()
        let yesterady = calendar.dateByAddingUnit(.Hour, value: -2, toDate: NSDate(), options: [])
        guard let interval = yesterady?.timeIntervalSince1970 else { return }

        healthHelper.queryTotalStepCount(sinceTimeInterval: interval) {
            (totalStepCount, error) in
            
            if let error = error {
                switch error {
                case .NoResult:
                    print("No result")
                case .NoDeviceSource:
                    print("No device source")
                case .NoSumQuantity:
                    print("No sum quantity")
                case .DefaultError:
                    print(error)
                }
            }
            
            if let totalStepCount = totalStepCount {
                print(Int(totalStepCount))
            }
        }
        
        healthHelper.queryTotalDistanceOnFoot(sinceTimeInterval: interval) {
            (totalDistance, error) in
            
            if let error = error {
                switch error {
                case .NoResult:
                    print("No result")
                case .NoDeviceSource:
                    print("No device source")
                case .NoSumQuantity:
                    print("No sum quantity")
                case .DefaultError:
                    print(error)
                }
            }
            
            if let totalDistance = totalDistance {
                print(Int(totalDistance))
            }
            
        }

    }
    
}
