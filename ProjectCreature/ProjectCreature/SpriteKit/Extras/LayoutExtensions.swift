//
//  LayoutHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/27/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit


extension SKNode {
    
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
    
    // MARK: - Basic positioning
    
    func setPosition(x: CGFloat, y: CGFloat) {
        
        self.position = CGPoint(x: x, y: y)
        
    }
    
    // MARK: - Marginal positioning
    
    func setVerticalPosition(value: CGFloat, fromMargin margin: VerticalMargin) {
        
        guard let parent = self.parent else { return }
        
        switch margin {
        case .TopMargin:
            self.position = CGPoint(x: self.position.x, y: parent.frame.maxY - value)
        case .BottomMargin:
            self.position = CGPoint(x: self.position.y, y: parent.frame.minY + value)
        }
        
    }
    
    func setHorizontalPosition(value: CGFloat, fromMargin margin: HorizontalMargin) {
        
        guard let parent = self.parent else { return }
        
        switch margin {
        case .LeftMargin:
            self.position = CGPoint(x: parent.frame.minX + value, y: self.position.y)
        case .RightMargin:
            self.position = CGPoint(x: parent.frame.maxX - value, y: self.position.y)
        }
        
    }
    
    // MARK: - Relative positioning
    
    func setHorizontalPosition(horizontalPosition: HorizontalPosition) {
        
        guard let parent = self.parent else { return }
        
        switch horizontalPosition {
        case .Left:
            self.position = CGPoint(x: parent.frame.minX, y: self.position.y)
        case .Center:
            self.position = CGPoint(x: parent.frame.maxX / 2, y: self.position.y)
        case .Right:
            self.position = CGPoint(x: parent.frame.maxX, y: self.position.y)
        }
        
    }
    
    func setVerticalPosition(verticalPosition: VerticalPosition) {
        
        guard let parent = self.parent else { return }
        
        switch verticalPosition {
        case .Top:
            self.position = CGPoint(x: self.position.x, y: parent.frame.maxY)
        case .Middle:
            self.position = CGPoint(x: self.position.x, y: parent.frame.maxY / 2)
        case .Bottom:
            self.position = CGPoint(x: self.position.x, y: parent.frame.minY)
        }
        
    }
    
    // MARK: - Positioning relative to node
    
    func setVerticalPosition(value: CGFloat, relativeTo node: SKNode) {
        
        self.position = CGPoint(x: self.position.x, y: node.position.y + value)

        let offset = node.frame.height / 2
        if (self.position.y < node.position.y) {
            self.position.y -= offset
        }
        if (self.position.y > node.position.y) {
            self.position.y += offset
        }
        
    }
    
    func setHorizontalPosition(value: CGFloat, relativeTo node: SKNode) {
        
        self.position = CGPoint(x: node.position.x + value, y: self.position.y)
        
        let offset = node.frame.width / 2
        if (self.position.x < node.position.x) {
            self.position.x -= offset
        }
        if (self.position.x > node.position.x) {
            self.position.x += offset
        }
        
    }
    
}