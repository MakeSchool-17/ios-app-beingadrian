//
//  StatsScene.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/3/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class StatsScene: SKScene {
    
    var disposeBag = DisposeBag()
    
    // MARK: - UI Properties
    
    var background: SKSpriteNode!
    
    // MARK: - Base methods
    
    override func didMoveToView(view: SKView) {
        
        let _ = StatsSceneUI(scene: self)
        
    }
    
}
