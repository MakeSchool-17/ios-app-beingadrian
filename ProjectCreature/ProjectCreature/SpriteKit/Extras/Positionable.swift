//
//  Positionable.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/27/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit


enum VerticalMargin {
    case TopMargin
    case BottomMargin
}

enum HorizontalMargin {
    case LeftMargin
    case RightMargin
}

enum HorizontalPosition {
    case Left
    case Right
    case Center
}

enum VerticalPosition {
    case Top
    case Middle
    case Bottom
}

protocol Positionable {
    
    // MARK: - Basic positioning
    
    func setPosition(x: CGFloat, y: CGFloat)
    
    // MARK: - Marginal positioning
    
    func setVerticalPosition(value: CGFloat, fromMargin margin: VerticalMargin)
    
    func setHorizontalPosition(value: CGFloat, fromMargin margin: HorizontalMargin)
    
    // MARK: - Relative positioning
    
    func setHorizontalPosition(horizontalPosition: HorizontalPosition)
    
    func setVerticalPosition(verticalPosition: VerticalPosition)
    
    // MARK: - Positioning relative to node
    
    func setVerticalPosition(value: CGFloat, relativeTo node: SKNode)
    
    func setHorizontalPosition(value: CGFloat, relativeTo node: SKNode)
    
}