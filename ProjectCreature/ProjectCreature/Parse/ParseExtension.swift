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
    
    func saveLocallyInBackground() -> Promise<Bool> {
        
        return Promise { (adapter: (Bool, NSError?) -> Void) in
            self.pinInBackgroundWithBlock(adapter)
        }
        
    }
    
}