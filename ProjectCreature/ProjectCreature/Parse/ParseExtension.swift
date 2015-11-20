//
//  ParseExtension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/18/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import PromiseKit


extension PFObject {
    
    private typealias PFBooleanResultAdapter = (Bool, NSError?) -> Void
    
    func pinInBackgroundWithBlock() -> Promise<Bool> {
        
        return Promise { (adapter: PFBooleanResultAdapter) in
            self.pinInBackgroundWithBlock(adapter)
        }
        
    }
    
    func unpinInBackgroundWithBlock() -> Promise<Bool> {
        
        return Promise { (adapter: PFBooleanResultAdapter) in
            self.unpinInBackgroundWithBlock(adapter)
        }
        
    }
    
    func saveEventually() -> Promise<Bool> {
        
        return Promise { (adapter: PFBooleanResultAdapter) in
            self.saveEventually(adapter)
        }
        
    }
    
}