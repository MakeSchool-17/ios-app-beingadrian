//
//  DashboardScene.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift
import RxCocoa
import UIKit


class DashboardScene: SKScene {
    
    var disposeBag = DisposeBag()
    
    // MARK: - UI Properties
    
    var background: SKSpriteNode!
    var statsButton: StatsButton!
    var menuButton: MenuButton!
    
    var dashboard: SKSpriteNode!
    var circleFrame: SKSpriteNode!
    
    var creatureNameLabel: SKLabelNode!
    var lvLabel: SKLabelNode!
    var creatureLevelLabel: SKLabelNode!
    
    var hpBarBack: SKSpriteNode!
    var hpBarFront: BarHorizontal!
    var hpBarCrop: SKCropNode!
    var hpLabel: SKLabelNode!
    var hpPercentageLabel: SKLabelNode!
    
    var expBarBack: SKSpriteNode!
    var expBarFront: BarHorizontal!
    var expBarCrop: SKCropNode!
    var expLabel: SKLabelNode!
    
    var energyGroup: SKNode!
    var energyLabel: SKLabelNode!
    var energyIcon: SKSpriteNode!
    
    var creature: Creature?
    var gameManager: GameManager?
    
    var viewModel: DashboardViewModel?
    
    
    // MARK: - Base methods
    
    override func didMoveToView(view: SKView) {
        
        setupUI()
    
        parseHelper.retrieveUserCreatureParseObjectFrom(.Local)
            .subscribe(
                onNext: { (object) -> Void in
                    guard let creature = object as? Creature else { return }
                    self.creature = creature
                    self.viewModel = DashboardViewModel(creature: self.creature!)
                    self.gameManager = GameManager(creature: creature)
                    self.bindUI()
                },
                onError: { (error) -> Void in
                    print("> Error retrieving user creature")
                },
                onCompleted: { () -> Void in
                    print("> Complete retrieving user creature")
                }) { () -> Void in
                    print("> Disposed retrieve creature subscription")
            }
            .addDisposableTo(disposeBag)
        
        transitionIn()
    }
    
    func testCreateCreature() -> Creature {
        
        // TEST: initial creature creation
        let testCreature = Creature()
        testCreature.name = "Rob"
        testCreature.family = "Background"
        testCreature.hp = 100
        testCreature.hpMax = 200
        testCreature.exp = 100
        testCreature.expMax = 200
        testCreature.owner = PFUser.currentUser()!
        
        return testCreature
        
    }
    
    func bindUI() {
        
        guard let viewModel = viewModel else { return }
        
        viewModel.creatureName
            .subscribeNext {
                self.creatureNameLabel.text = $0
                self.readjustLevelLabelXPosition()
            }
            .addDisposableTo(disposeBag)
        
        viewModel.creatureLevel
            .bindTo(creatureLevelLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.creatureHpPercentage
            .map {
                self.hpBarFront.animateBarProgress(toPercentage: $0)
                return String(Int($0)) + "%"
            }
            .bindTo(hpPercentageLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.creatureExpPercentage
            .subscribeNext {
                self.expBarFront.animateBarProgress(toPercentage: $0)
            }
            .addDisposableTo(disposeBag)
        
        // TODO: Binding with sprite
        
        viewModel.cash
            .bindTo(energyLabel.rx_text)
            .addDisposableTo(disposeBag)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.locationInNode(self)
        
        let touchedNode = self.nodeAtPoint(touchLocation)
        
        if let _ = touchedNode as? NavigationButton {
            
            transitionOut()
            
//            let statsLayer = StatsLayer(size: self.frame.size, scene: self)
//            addChild(statsLayer)
        }
        
    }
    
}

extension DashboardScene: CreatureOwner {}