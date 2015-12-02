//
//  DashboardScene.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class DashboardScene: SKScene {
    
    let healthHelper = HKHelper()
    let parseHelper = ParseHelper()
    
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    var background: SKSpriteNode!
    var statsButton: SKButton!
    var menuButton: SKButton!
    
    var dashboard: SKSpriteNode!
    var circleFrame: SKSpriteNode!
    
    var creatureNameLabel: SKLabelNode!
    var lvLabel: SKLabelNode!
    var creatureLevelLabel: SKLabelNode!
    
    var healthBarBack: SKSpriteNode!
    var healthBarFront: SKSpriteNode!
    var healthBarCrop: SKCropNode!
    var HPLabel: SKLabelNode!
    var HPPercentageLabel: SKLabelNode!
    
    var expBarBack: SKSpriteNode!
    var expBarFront: SKSpriteNode!
    var expBarCrop: SKCropNode!
    var EXPLabel: SKLabelNode!
    
    var viewModel: DashboardViewModel! {
        didSet {
            self.creatureNameLabel.text = viewModel.creatureName
            self.creatureLevelLabel.text = viewModel.creatureLevel
        }
    }
    
    // MARK: - Base methods
    
    override func didMoveToView(view: SKView) {
        
        setup()
        
        // FIXME: Testing
        parseHelper.retrieveUserCreatureParseObjectFrom(.Server)
            .subscribeNext { object in
                if let creature = object as? Creature {
                    print(creature)
                }
            }
            .addDisposableTo(disposeBag)
        
    }
    
    func setup() {
        
        // setup scene UI
        // TODO: Function or initializer
        let _ = DashboardSceneUI(scene: self)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        
        if statsButton.containsPoint(location) {
            statsButton.touchesBegan(touches, withEvent: event)
        }
        
        if menuButton.containsPoint(location) {
            menuButton.touchesBegan(touches, withEvent: event)
        }

    }
    
}
