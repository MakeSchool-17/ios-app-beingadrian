//
//  StoreLayer.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/21/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class StoreLayer: SKSpriteNode {
    
    var disposeBag = DisposeBag()
    
    // MARK: - UI Properties
    
    
    
    // MARK: - Base methods 
    
    init(size: CGSize) {
        
        let texture = SKTexture(imageNamed: "Background")
        super.init(texture: texture, color: UIColor(), size: size)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    // MARK: - Touch handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // insert code here
        
    }
    
    
}

extension StoreLayer: RxCompliant {}
