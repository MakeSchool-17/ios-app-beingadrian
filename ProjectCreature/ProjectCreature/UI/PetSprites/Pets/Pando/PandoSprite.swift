//
//  PandoSprite.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/7/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class PandoSprite: PetSprite {

    // MARK: - Initialization
    
    override init() {
        super.init()
        
        self.familyName = "Pando"
        self.observeState()

    }
    
    override func observeState() {
        
        state
            .subscribeNext { state in
                switch state {
                case .Neutral:
                    self.neutral()
                case .Happy:
                    self.happy()
                case .Sad:
                    self.sad()
                case .Asleep:
                    self.asleep()
                case .Fainted:
                    self.fainted()
                }
            }
            .addDisposableTo(disposeBag)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }

}
