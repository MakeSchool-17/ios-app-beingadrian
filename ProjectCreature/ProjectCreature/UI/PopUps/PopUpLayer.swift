//
//  PopUpLayer.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/13/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import SpriteKit


class PopUpLayer: SKSpriteNode {
    
    // MARK: - Initialization
    
    init(size: CGSize, newSteps: Int, petName: String) {
        
        let whiteColor = UIColor(
            red: 1, green: 1, blue: 1, alpha: 0.8)
        super.init(texture: nil, color: whiteColor, size: size)

        self.anchorPoint = CGPointZero
        self.zPosition = 51
        
    }
    
    func setupUI() {}
    
    /**
     * Creates a rounded rectangle for the background 
     * of the pop-up. The style of the pop-up is default.
     * (with a grey stroke and white fill).
     *
     * - parameter width: Width of the rounded rectangle.
     * - parameter height: Height of the rounded rectangle.
     * - returns: A rounded rectangle (an SKShapeNode).
     */
    func createRoundedRectangle(width: CGFloat, height: CGFloat) -> SKShapeNode {

        // rect settings
        let rectSize = CGSize(width: width, height: height)
        let popUpBackground = SKShapeNode(
            rectOfSize: rectSize,
            cornerRadius: 24)
        
        // line settings
        popUpBackground.lineWidth = 6.5
        popUpBackground.strokeColor = UIColor.rgbaColor(
            r: 115, g: 115, b: 115, a: 1)
        popUpBackground.fillColor = UIColor.whiteColor()
    
        return popUpBackground

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    // MARK: - Transitions
    
    func transitionIn() {
        

        
    }
    
    func transitionOut() {
        
//        let scaleDownAction = SKAction
        
    }
    
}
