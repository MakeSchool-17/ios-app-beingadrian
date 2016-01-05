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
    
    private let firebaseHelper = FirebaseHelper()
    
    weak var gameManager: GameManager!
    
    // MARK: - UI Properties
    
    var viewModel: DashboardViewModel!
    
    var statsButton: SKButtonSprite!
    var menuButton: SKButtonSprite!
    
    var dashboard: SKSpriteNode!
    var circleFrame: SKSpriteNode!
    
    var creatureNameLabel: SKLabelNode!
    var lvLabel: SKLabelNode!
    var creatureLevelLabel: SKLabelNode!
    
    var hpBarFront: BarHorizontal!
    var hpPercentageLabel: SKLabelNode!
    
    var expBarFront: BarHorizontal!
    var expLabel: SKLabelNode!
    
    var energyGroup: SKNode!
    var energyLabel: SKLabelNode!
    var energyIcon: SKSpriteNode!
    
    var creatureModel: PandoModel!
    
    // MARK: - Did move to view
    
    override func didMoveToView(view: SKView) {
        
        setup()
        
        bindUI()
        
        gameManager.statsStore.reloadData()
        
        transitionIn {
            self.observePetting()
        }
        
    }
    
    private func setup() {
        
        self.size = CGSize(width: 320, height: 568)
        
        setupUI()
    
        self.userInteractionEnabled = true
        
    }
    
    // MARK: - Binding
    
    private func bindUI() {
        
        viewModel.creatureName
            .subscribeOn(MainScheduler.sharedInstance)
            .subscribeNext { name in
                self.creatureNameLabel.text = name
                self.readjustLevelLabelXPosition()
            }
            .addDisposableTo(disposeBag)
        
        viewModel.creatureLevel
            .observeOn(MainScheduler.sharedInstance)
            .bindTo(creatureLevelLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.creatureHpPercentage
            .subscribeOn(MainScheduler.sharedInstance)
            .subscribeNext { percentage in
                self.hpBarFront.animateBarProgress(toPercentage: percentage / 100)
                self.hpPercentageLabel.animateToValue(
                    percentage,
                    fromValue: 0,
                    duration: 0.5,
                    rounded: true,
                    addString: "%")
            }
            .addDisposableTo(disposeBag)
        
        viewModel.creatureExpPercentage
            .subscribeOn(MainScheduler.sharedInstance)
            .map { return $0 / 100 }
            .subscribeNext { percentage in
                self.expBarFront.animateBarProgress(toPercentage: percentage)
            }
            .addDisposableTo(disposeBag)
        
        viewModel.creatureModel
            .subscribeOn(MainScheduler.sharedInstance)
            .subscribeNext { model in
                self.creatureModel = model
                self.creatureModel.position.x = self.frame.halfWidth
                self.creatureModel.position.y = self.frame.halfHeight - 105
                self.addChild(self.creatureModel)
            }
            .addDisposableTo(disposeBag)
        
        viewModel.cash
            .observeOn(MainScheduler.sharedInstance)
            .bindTo(energyLabel.rx_text)
            .addDisposableTo(disposeBag)
        
    }
    
    private func observePetting() {
        
        guard let gameManager = self.gameManager else { return }
        
        let maxHpValue = Int(gameManager.creature.hpMax.value)
        
        creatureModel.head.pettingCount
            .subscribeNext { count in
                if (count != 0) {
                    let currentHpValue = gameManager.creature.hp.value
                    let newValue = (currentHpValue + 5).clamped(0...maxHpValue)
                    gameManager.creature.hp.value = newValue
                }
            }
            .addDisposableTo(disposeBag)
        
    }
    
    // MARK: - Touch handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.locationInNode(self)
        
        let touchedNode = self.nodeAtPoint(touchLocation)
        
        if touchedNode.isEqualToNode(statsButton) {
            pushStatsLayer()
        } else if touchedNode.isEqualToNode(menuButton) {
            pushMenuLayer()
        }
        
    }
    
    // MARK: - Navigation
    
    private func pushStatsLayer() {
        
        self.userInteractionEnabled = false
        
        guard let gameManager = self.gameManager else { return }
        
        self.transitionOut {
            let statsLayer = StatsLayer(
                size: self.frame.size,
                gameManager: gameManager)
            self.addChild(statsLayer)
            statsLayer.transitionIn {
                // enable user interaction once transition is complete
                statsLayer.userInteractionEnabled = true
            }
        }
        
    }
    
    private func pushMenuLayer() {
        
        let menuLayer = MenuLayer(size: self.frame.size)
        self.addChild(menuLayer)
        menuLayer.transitionIn()
        
    }
    
}

extension DashboardScene: RxCompliant {}
