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

/**
 * The main scene of the app. The DashboardScene manages any 
     * reactive UI changes as well as UI input.
 */
class DashboardScene: SKScene {
    
    var disposeBag = DisposeBag()
    
    var gameManager: GameManager!
    
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
    
    var chargeGroup: SKNode!
    var chargeLabel: SKLabelNode!
    var chargeIcon: SKSpriteNode!
    
    var petSprite: PetSprite!
    var foodSprite: FoodSprite?
    
    // MARK: - Did move to view
    
    override func didMoveToView(view: SKView) {
        
        pushLoadingScreen()
        
        setup()
        
        performCheck()
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: nil,
                onError: { (error) -> Void in
                    print("> Failed performing initial check: \(error)")
                    self.didFinishPerformingInitialCheck()
                },
                onCompleted: {
                    print("> Completed performing initial check")
                    self.didFinishPerformingInitialCheck()
                },
                onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
    
    private func setup() {
        
        setupUI()
        
        bindUI()
    
        self.userInteractionEnabled = true
        
    }
    
    // MARK: - Checks
    
    /**
     * A method called when the application becomes active again.
     * The main purpose of the method is to reload data and perform
     * checks. The method is called from the AppDelegate.
     */
    func didBecomeActive() {
        
        pushLoadingScreen()
        
        performCheck()
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: nil,
                onError: { (error) -> Void in
                    print("> Failed performing check: \(error)")
                },
                onCompleted: {
                    print("> Completed performing check")
                    self.loadingLayer.didFinishLoading()
                },
                onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
    
    /**
     * Reloads the data of the `gameManager`'s `statsStore`. 
     * Error handling also occurs in this function.
     */
    private func performCheck() -> Observable<Void> {
        
        return HKHelper().requestHealthKitAuthorization()
            .flatMap { success -> Observable<Void> in
                if success {
                    print("> Successfully authorized HealthKit")
                    return self.gameManager.statsStore.reloadData()
                } else {
                    print("> Failed to authorize HealthKit")
                    return Observable.empty()
                }
            }
        
    }
    
    /**
     * Performs a series of actions upon the successful completion 
     * of `performCheck`.
     */
    private func didFinishPerformingInitialCheck() {

        self.loadingLayer.didFinishLoading()
        self.transitionIn {
            self.makeObservations()
            self.checkForNewSteps()
        }
        
    }
    
    // MARK: - New steps pop-up
    
    /**
     * Checks the gameManager's statsStore for its `newSteps`
     * property.
     *
     * If there are new steps, the NewStepsPopUp layer will be pushed 
     * onto the screen.
     */
    private func checkForNewSteps() {
        
        let newSteps = Int(gameManager.statsStore.newSteps)
        
        print("> Dashboard - newSteps: \(newSteps)")
        
        guard (newSteps != 0) else { return }
        
        let delayAction = SKAction.waitForDuration(1.2)
        
        let actionBlock = SKAction.runBlock {
            self.pushNewStepsPopUp(newSteps)
            self.gameManager.user.charge.value += newSteps
        }
        
        let actionSequence = SKAction.sequence([delayAction, actionBlock])

        self.runAction(actionSequence)
        
    }
    
    // MARK: - Binding and general observations
    
    /**
     * Binds the UI with the viewModel data.
     */
    private func bindUI() {
        
        viewModel.petName
            .asObservable()
            .subscribeOn(MainScheduler.instance)
            .subscribeNext { name in
                self.petNameLabel.text = name
                self.readjustLevelLabelXPosition()
            }
            .addDisposableTo(disposeBag)
        
        viewModel.petLevel
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bindTo(petLevelLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.petHpPercentage
            .asObservable()
            .subscribeOn(MainScheduler.instance)
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
            .asObservable()
            .subscribeOn(MainScheduler.instance)
            .map { return $0 / 100 }
            .subscribeNext { percentage in
                self.expBarFront.animateBarProgress(toPercentage: percentage)
            }
            .addDisposableTo(disposeBag)
        
        viewModel.cash
            .asObservable()
            .subscribeOn(MainScheduler.instance)
            .subscribeNext { cashString in
                self.chargeLabel.text = cashString
                self.chargeIcon.position.x = self.chargeLabel.frame.minX - 7
            }
            .addDisposableTo(disposeBag)
        
        viewModel.petSprite
            .asObservable()
            .subscribeOn(MainScheduler.instance)
            .subscribeNext { model in
                self.petSprite = model
                self.petSprite.position.x = self.frame.halfWidth
                self.petSprite.position.y = self.frame.halfHeight - 105
                self.addChild(self.petSprite)
            }
            .addDisposableTo(disposeBag)
        
    }
    
    private func makeObservations() {
        
        observePetting()
        observePetLevelUp()
        observeFood()
        
    }
    
    /**
     * Bridges communication between the petting action and data 
     * changes with the pet object.
     */
    private func observePetting() {
        
        guard let gameManager = self.gameManager else { return }
        guard let petSprite = self.petSprite else { return }
        
        petSprite.head.isBeingPet
            .subscribeOn(MainScheduler.instance)
            .subscribeNext { count in
                
                let limitIsReached = gameManager.checkPettingLimitIsReached()
                
                if !limitIsReached {
                    
                    gameManager.pettingCount.value += 1
                    
                    let head = petSprite.head
                    if (!head.isSmiling && self.petSprite.state.value != .Sad) {
                        self.petSprite.smileForDuration(1)
                    }
                }
            }
            .addDisposableTo(disposeBag)
        
    }
    
    /**
     * Creates an observer for `gameManager`'s `petLeveledUp` 
     * property that is triggered
     * when the pet has leveled up.
     */
    private func observePetLevelUp() {
        
        gameManager.petLeveledUp
            .subscribeNext { newLevel in
                print("> Dashboard - Pet did level up: \(newLevel)")
            }.addDisposableTo(disposeBag)
        
    }
    
    /**
     * Creates an observer for 'gameManager''s 'currentFood'.
     * Inserts new food on the plate.
     */
    private func observeFood() {
        
        gameManager.currentFood
            .asObservable()
            .subscribeNext { food in
                guard let food = food else { return }
                print("> New food: \(food.name)")
                let simplePie = Food(name: "Simple pie", hpValue: 90)
                self.insertFood(simplePie)
            }
            .addDisposableTo(disposeBag)
        
    }
    
    // MARK: - Food
    
    private func insertFood(food: Food) {
        
        let foodSprite = FoodSprite(food: food)
        foodSprite.position = CGPoint(x: frame.midX, y: frame.minY + 100)
        foodSprite.initialPosition = foodSprite.position
        foodSprite.zPosition = 5
        self.addChild(foodSprite)
        
        observeFoodSprite(foodSprite)
        
    }
    
    /**
     * Executes a series of animations for food consumption.
     * Also calls the `consumeFood` method on the gameManager.
     */
    private func consumeFoodSprite(foodSprite: FoodSprite) {
        
        petSprite.smileForDuration(2.0)
        foodSprite.performEatenAction {
            self.gameManager.consumeFood(foodSprite.food)
        }
        
    }
    
    private func observeFoodSprite(foodSprite: FoodSprite) {
        
        foodSprite.onTouchRelease
            .subscribeNext { releasePosition in
                let point = self.convertPoint(releasePosition, toNode: self.petSprite.head)
                if self.petSprite.feedingArea.containsPoint(point) {
                    self.consumeFoodSprite(foodSprite)
                } else {
                    foodSprite.returnToOriginalPosition()
                }
            }.addDisposableTo(disposeBag)
        
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
    
    func pushLoadingScreen() {
        
        self.loadingLayer = LoadingLayer(size: self.size)
        loadingLayer.zPosition = 100
        self.addChild(loadingLayer)
        loadingLayer.transitionIn()
        
    }
    
    private func pushNewStepsPopUp(newSteps: Int) {
        
        let reportPopUp = ProgressReportPopUp(size: self.size, newSteps: newSteps, petName: "Pando")
        self.addChild(reportPopUp)
        reportPopUp.transitionIn()
        
    }
    
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
