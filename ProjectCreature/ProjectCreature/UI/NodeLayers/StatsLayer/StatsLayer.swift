//
//  StatsLayer.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/7/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class StatsLayer: SKSpriteNode {
    
    private var disposeBag = DisposeBag()
    
    // MARK: - UI Properties
    
    var statisticsTitleLabel: SKLabelNode!
    
    var distanceTitleLabel: SKLabelNode!
    var distanceValueLabel: SKLabelNode!
    var distanceUnitLabel: SKLabelNode!

    var progressTitleLabel: SKLabelNode!
    var progressValueLabel: SKLabelNode!
    
    var stepCircleGroup: SKSpriteNode!
    var totalStepsTitleLabel: SKLabelNode!
    var totalStepsValueLabel: SKLabelNode!
    var dateLabel: SKLabelNode!
    
    var circleBack: CircleProgressBar!
    var circleFront: CircleProgressBar!
    
    var histogramGroup: SKSpriteNode!
    var histogramBarsBack: SKSpriteNode!
    var histogramPointer: HistogramPointer!
    var histogramBarsFront: [BarVertical] = []
    
    var closeButton: SKSpriteNode!
    
    weak var viewModel: StatsViewModel?
    
    // MARK: - Base methods
    
    init(size: CGSize) {
        
        let texture = SKTexture(imageNamed: "Background")
        super.init(texture: texture, color: UIColor(), size: size)
        
        // initially disable user interaction to avoid touch conflicts during transition
        self.userInteractionEnabled = false
        
        self.alpha = 0
        
        setupUI()
        
        self.viewModel = StatsViewModel()
        
        bindUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    func bindUI() {
        
        guard let viewModel = self.viewModel else { return }
        
        viewModel.distance
            .delaySubscription(1.0, MainScheduler.sharedInstance)
            .subscribeOn(MainScheduler.sharedInstance)
            .map { return $0 / 1000 }
            .subscribeNext { distance in
                self.distanceValueLabel.animateToValueFromZero(
                    distance,
                    duration: 1,
                    rounded: false)
            }
            .addDisposableTo(disposeBag)
        
        distanceValueLabel.rx_observeWeakly(String.self, "text")
            .subscribeNext { (_: String?) in
                self.distanceUnitLabel.position.x = self.distanceValueLabel.frame.width + 3
            }
            .addDisposableTo(disposeBag)

        viewModel.progress
            .delaySubscription(1.0, MainScheduler.sharedInstance)
            .subscribeOn(MainScheduler.sharedInstance)
            .subscribeNext { progress in
                self.circleFront.animateToProgress(1.0, progress: progress / 100)
                self.progressValueLabel.animateToValueFromZero(
                    progress,
                    duration: 1,
                    rounded: true,
                    addString: "%")
            }
            .addDisposableTo(disposeBag)

        viewModel.totalSteps
            .delaySubscription(1.0, MainScheduler.sharedInstance)
            .subscribeOn(MainScheduler.sharedInstance)
            .map { return Float($0) }
            .subscribeNext { totalSteps in
                self.totalStepsValueLabel.animateToValueFromZero(
                    totalSteps,
                    duration: 1,
                    rounded: true)
            }
            .addDisposableTo(disposeBag)
        
        viewModel.date
            .observeOn(MainScheduler.sharedInstance)
            .bindTo(self.dateLabel.rx_text)
            .addDisposableTo(disposeBag)

        viewModel.pointerIndex
            .subscribeOn(MainScheduler.sharedInstance)
            .subscribeNext { index in
                let bar = self.histogramBarsFront[index-1]
                self.histogramPointer.animateToBar(bar)
            }
            .addDisposableTo(disposeBag)
        
        for i in 0...(histogramBarsFront.count-1) {
            
            viewModel.weekProgresses[i]
                .delaySubscription(1.0, MainScheduler.sharedInstance)
                .subscribeOn(MainScheduler.sharedInstance)
                .subscribeNext { progress in
                    self.histogramBarsFront[i].animateBarProgress(toPercentage: progress)
                }
                .addDisposableTo(disposeBag)
            
        }
        
    }
    
    // MARK: - Touch handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.locationInNode(self)
        
        let touchedNode = self.nodeAtPoint(touchLocation)
        
        if touchedNode.isEqualToNode(closeButton) {
            self.transitionOut {
                guard let dashboardScene = self.parent as? DashboardScene else { return }
                dashboardScene.transitionIn {
                    self.viewModel?.disposeBag = DisposeBag()
                    self.disposeBag = DisposeBag()
                    self.removeFromParent()
                    dashboardScene.userInteractionEnabled = true
                }
            }
        }
        
    }
    
    // MARK: - Transitions
    
    typealias TransitionCallback = () -> Void
    
    func transitionIn(completion: TransitionCallback) {
        
        self.stepCircleGroup.setScale(0)
        let scaleAction = SKAction.scaleTo(1,
            duration: 1,
            delay: 0,
            usingSpringWithDamping: 0.7, 
            initialSpringVelocity: 0)
        
        let fadeInAction = SKAction.fadeInWithDuration(0.35)
        
        let transitionAction = SKAction.runBlock {
            self.stepCircleGroup.runAction(scaleAction)
            self.runAction(fadeInAction)
        }
        
        self.runAction(transitionAction, completion: completion)
        
    }
    
    func transitionOut(completion: TransitionCallback) {
        
        // disable user interaction to avoid touch conflicts
        self.userInteractionEnabled = false
        
        let fadeOutAction = SKAction.fadeOutWithDuration(0.15)
        
        self.runAction(fadeOutAction, completion: completion)
        
    }

}
