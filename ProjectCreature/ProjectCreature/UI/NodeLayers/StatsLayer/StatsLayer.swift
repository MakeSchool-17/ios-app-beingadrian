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
    
    var disposeBag = DisposeBag()
    
    private let gameManager: GameManager
    
    // MARK: - UI Properties
    
    private let viewModel: StatsViewModel
    
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
    
    // MARK: - Base methods
    
    init(size: CGSize, gameManager: GameManager) {
        
        self.gameManager = gameManager
        
        self.viewModel = StatsViewModel(statsStore: self.gameManager.statsStore)
        
        let texture = SKTexture(imageNamed: "Background")
        super.init(texture: texture, color: UIColor(), size: size)
        
        // initially disable user interaction to avoid touch conflicts during transition
        self.userInteractionEnabled = false
        
        self.alpha = 0
        
        setupUI()
        
        udpateUI()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    private func udpateUI() {
        
        distanceValueLabel.animateToValueFromZero(
            viewModel.distance,
            duration: 1,
            rounded: false)
        
        let currentWeekday = NSDate().weekday
        
        guard let progressToday = viewModel.weekProgresss[currentWeekday] else { return }
        progressValueLabel.animateToValueFromZero(
            progressToday * 100,
            duration: 1,
            rounded: true,
            addString: "%")
        
        totalStepsValueLabel.animateToValueFromZero(
            viewModel.totalSteps,
            duration: 1,
            rounded: true)
        
        dateLabel.text = viewModel.date
        
        circleFront.animateToProgress(1, progress: progressToday)
        
        let bar = histogramBarsFront[currentWeekday-1]
        histogramPointer.animateToBar(bar)
        
        for (weekday, progress) in viewModel.weekProgresss {
            histogramBarsFront[weekday-1].animateBarProgress(toPercentage: progress)
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
                    self.viewModel.cleanDisposeBag()
                    self.cleanDisposeBag()
                    self.removeFromParent()
                    dashboardScene.userInteractionEnabled = true
                }
            }
        }
        
    }
    
    // MARK: - Transitions
    
    typealias TransitionCallback = () -> Void
    
    func transitionIn(completion: TransitionCallback) {
        
        self.setScale(0)
        self.stepCircleGroup.setScale(0)
        let scaleAction = SKAction.scaleTo(1,
            duration: 1,
            delay: 0,
            usingSpringWithDamping: 0.7, 
            initialSpringVelocity: 0)
        
        let fadeInAction = SKAction.fadeInWithDuration(0.35)
        let actionGroup = SKAction.group([fadeInAction, scaleAction])
        
        let transitionAction = SKAction.runBlock {
            self.stepCircleGroup.runAction(scaleAction)
            self.runAction(actionGroup)
        }
        
        self.runAction(transitionAction, completion: completion)
        
    }
    
    private func transitionOut(completion: TransitionCallback) {
        
        // disable user interaction to avoid touch conflicts
        self.userInteractionEnabled = false
        
        let scaleDownAction = SKAction.scaleTo(0, duration: 0.25)
        let fadeOutAction = SKAction.fadeOutWithDuration(0.15)
        let actionGroup = SKAction.group([scaleDownAction, fadeOutAction])
        
        self.runAction(actionGroup, completion: completion)
        
    }

}

extension StatsLayer: RxCompliant {}
