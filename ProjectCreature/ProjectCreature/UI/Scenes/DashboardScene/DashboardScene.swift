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
    
    var loadingLayer: LoadingLayer!
    
    var statsButton: SKButtonSprite!
    var menuButton: SKButtonSprite!
    
    var dashboard: SKSpriteNode!
    var circleFrame: SKSpriteNode!
    
    var petNameLabel: SKLabelNode!
    var lvLabel: SKLabelNode!
    var petLevelLabel: SKLabelNode!
    
    var hpBarFront: BarHorizontal!
    var hpPercentageLabel: SKLabelNode!
    
    var expBarFront: BarHorizontal!
    var expLabel: SKLabelNode!
    
    var energyGroup: SKNode!
    var energyLabel: SKLabelNode!
    var energyIcon: SKSpriteNode!
    
    var petSprite: PetSprite!
    
    // MARK: - Did move to view
    
    override func didMoveToView(view: SKView) {
        
        setup()
        
        reloadData()
        
        transitionIn {
            self.observePetting()
        }
        
    }
    
    private func setup() {
        
        setupUI()
        
        bindUI()
    
        self.userInteractionEnabled = true
        
        showLoadingScreen()
        
        // TODO: Food implementation
        let simplePie = Food(name: "Simple pie", hpValue: 20)
        let simplePieSprite = FoodSprite(food: simplePie)
        simplePieSprite.position = CGPoint(x: frame.midX, y: frame.minY + 100)
        self.addChild(simplePieSprite)
        
        // TODO: Observe food isTapped
        simplePieSprite.isTapped
            .subscribeNext { isTapped in
                if isTapped {
                     self.gameManager.consumeFood(simplePieSprite.food)
                }
            }.addDisposableTo(disposeBag)
        
    }
    
    private func showLoadingScreen() {
        
        self.loadingLayer = LoadingLayer(size: self.size)
        loadingLayer.zPosition = 100
        self.addChild(loadingLayer)
        
    }
    
    private func reloadData() {
        
        gameManager.statsStore.reloadData()
            .subscribe(
                onNext: nil,
                onError: { (error) -> Void in
                    print("> Error reloading stats data: \(error)")
                    self.loadingLayer.didFinishLoading()
                },
                onCompleted: {
                    print("> Completed reloading HK data")
                    self.loadingLayer.didFinishLoading()
                },
                onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
    
    // MARK: - Binding
    
    private func bindUI() {
        
        viewModel.petName
            .subscribeOn(MainScheduler.sharedInstance)
            .subscribeNext { name in
                self.petNameLabel.text = name
                self.readjustLevelLabelXPosition()
            }
            .addDisposableTo(disposeBag)
        
        viewModel.petLevel
            .observeOn(MainScheduler.sharedInstance)
            .bindTo(petLevelLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.petHpPercentage
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
        
        viewModel.petExpPercentage
            .subscribeOn(MainScheduler.sharedInstance)
            .map { return $0 / 100 }
            .subscribeNext { percentage in
                self.expBarFront.animateBarProgress(toPercentage: percentage)
            }
            .addDisposableTo(disposeBag)
        
        viewModel.petSprite
            .subscribeOn(MainScheduler.sharedInstance)
            .subscribeNext { model in
                self.petSprite = model
                self.petSprite.position.x = self.frame.halfWidth
                self.petSprite.position.y = self.frame.halfHeight - 105
                self.addChild(self.petSprite)
            }
            .addDisposableTo(disposeBag)
        
        viewModel.cash
            .observeOn(MainScheduler.sharedInstance)
            .bindTo(energyLabel.rx_text)
            .addDisposableTo(disposeBag)
        
    }
    
    private func observePetting() {
        
        guard let gameManager = self.gameManager else { return }
        
        let maxHpValue = Int(gameManager.pet.hpMax.value)
        
        petSprite.head.pettingCount
            .subscribeNext { count in

                let limitIsReached = gameManager.checkPettingLimitIsReached()
                
                if (count != 0 && !limitIsReached) {
                    
                    let head = self.petSprite.head
                    if !head.isSmiling {
                        head.smileTemporarily()
                    }
                    
                    let currentHpValue = gameManager.pet.hp.value
                    let newValue = (currentHpValue + 5).clamped(0...maxHpValue)
                    gameManager.pet.hp.value = newValue
                    gameManager.pettingCount.value += 1
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
