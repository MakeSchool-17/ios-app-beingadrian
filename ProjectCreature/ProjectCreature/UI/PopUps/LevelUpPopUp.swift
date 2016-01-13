//
//  LevelUpPopUp.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/12/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import SpriteKit


class LevelUpPopUp: SKSpriteNode {

    // MARK: - UI Properties
    
    var levelDescriptionLabel: SKLabelNode!
    
    // MARK: - Initialization
    
    init(size: CGSize) {
        
        let whiteColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        super.init(texture: nil, color: whiteColor, size: size)
        
        setupUI()
        
    }
    
    private func setupUI() {
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    // MARK: - Transitions
    
    func transitionIn() {
        
        
        
    }
    
    func transitionOut() {
        
        
        
    }
    
}
