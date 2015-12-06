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
    
    var viewModel: DashboardViewModel!
    
    // MARK: - Base methods
    
    override func didMoveToView(view: SKView) {
        
        setupUI()
        
        // bind UI if viewModel exists
        if let _ = viewModel { bindUI() }
        
    }
    
    func bindUI() {
        
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
                self.hpBarFront.changeBarProgress(byPercentage: $0)
                return String($0)
            }
            .bindTo(hpPercentageLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.creatureExpPercentage
            .subscribeNext {
                self.expBarFront.changeBarProgress(byPercentage: $0)
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
        
        if let button = touchedNode as? Button {
            button.touchesBegan(touches, withEvent: event)
        }
    
    }
    
}
