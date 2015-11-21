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
        
        
//        firstly {
//            parseHelper.retrieveUserCreatureParseObjectFrom(.Parse)
//        }.then { (object) in
//            object.deleteInBackgroundWithPromise()
//        }.then { (success) -> Promise<PFObject> in
//            print("Delete in background: \(success)")
//            return self.parseHelper.retrieveUserCreatureParseObjectFrom(.Local)
//        }.then { (object) in
//            object.unpinInBackgroundWithPromise()
//        }.then { (success) in
//            print("Unpin in background: \(success)")
//        }.error { (error) in
//            print(error)
//        }
        
//        let creature = Creature(name: "Bill", family: Creature.Family.FamilyA.rawValue, owner: PFUser.currentUser()!)
//        
//        let object = creature.parseObject()
//        
//        firstly {
//            return object.pinInBackgroundWithPromise()
//        }.then { success -> Promise<Bool> in
//            print("Pinning: \(success)")
//            return object.saveEventuallyWithPromise()
//        }.then { (success) in
//            print("Save eventually: \(success)")
//        }.error { error in
//            print(error)
//        }
        
    }
    
}
