//
//  AwardsLayer.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/21/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class AwardsLayer: SKSpriteNode {

    // MARK: - UI Properties
    
    let gameManager: GameManager
    
    // MARK: - Base methods 
    
    init(size: CGSize, gameManager: GameManager) {
        
        self.gameManager = gameManager
        
        let texture = SKTexture(imageNamed: "Background")
        super.init(texture: texture, color: UIColor(), size: size)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    func bindUI() {
        
        
        
    }
    
    // MARK: - Touch handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        
    }
    
}
