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
    
    private var disposeBag = DisposeBag()
    
    let firebaseHelper = FirebaseHelper()
    
    // MARK: - UI Properties
    
    var background: SKSpriteNode!
    var statsButton: SKButtonSprite!
    var menuButton: SKButtonSprite!
    
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
    
    override init(size: CGSize) { super.init(size: size) }

    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        setup()
        
        transitionIn {}
        
    }
    
    func setup() {
        
        setupUI()
    
        self.userInteractionEnabled = true
        
    }
    
    // MARK: - UI Binding
    
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
    
    func pushStatsLayer() {
        
        self.userInteractionEnabled = false
        
        self.transitionOut {
            let statsLayer = StatsLayer(size: self.frame.size)
            self.addChild(statsLayer)
            statsLayer.transitionIn {
                // enable user interaction once transition is complete
                statsLayer.userInteractionEnabled = true
            }
        }
        
    }
    
    func pushMenuLayer() {
        
        let menuLayer = MenuLayer(size: self.frame.size, scene: self)
        self.addChild(menuLayer)
        menuLayer.transitionIn()
        
    }
    
}