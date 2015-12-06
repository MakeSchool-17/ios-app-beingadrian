//
//  SKLabelNode+Rx.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/5/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit
import RxSwift


extension SKLabelNode {
    
    public var rx_text: AnyObserver<String> {
        return AnyObserver { [weak self] event in
            MainScheduler.ensureExecutingOnScheduler()
            
            switch event {
            case .Next(let value):
                self?.text = value
            case .Error(let error):
                print("Error binding to SKLabelNode: \(error)")
                break
            case .Completed:
                break
            }
        }
    }
    
}

    