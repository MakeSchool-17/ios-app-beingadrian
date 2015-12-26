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
import Firebase


class DashboardScene: SKScene {
    
    var disposeBag = DisposeBag()
    
    private let firebaseHelper = FirebaseHelper()
    
    private let gameManager: GameManager
    
    // MARK: - UI Properties
    
    private let viewModel: DashboardViewModel
    
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
    
    var creature: PandoModel!
    
    // MARK: - Init setup
    
    init(size: CGSize, gameManager: GameManager) {
        
        self.gameManager = gameManager
        
        self.viewModel = DashboardViewModel(
            creature: gameManager.creature,
            user: gameManager.user)
        
        super.init(size: size)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }

    // MARK: - Did move to view
    
    override func didMoveToView(view: SKView) {
        
        setup()
        
        bindUI()
        
        gameManager.statsStore.reloadData()
        
        transitionIn {}
        
        let pando = PandoModel()
        pando.position.x = frame.halfWidth
        pando.position.y = frame.halfHeight - 100
        self.addChild(pando)
        
    }
    
    private func setup() {
        
        setupUI()
    
        self.userInteractionEnabled = true
        
    }
    
    // MARK: - UI Binding
    
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
                self.hpPercentageLabel.animateToValueFromZero(
                    percentage,
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
        
        // TODO: Binding with sprite
        
        viewModel.cash
            .observeOn(MainScheduler.sharedInstance)
            .bindTo(energyLabel.rx_text)
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
    
    // MARK: - Segues
    
    private func pushStatsLayer() {
        
        self.userInteractionEnabled = false
        
        self.transitionOut {
            let statsLayer = StatsLayer(
                size: self.frame.size,
                gameManager: self.gameManager)
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