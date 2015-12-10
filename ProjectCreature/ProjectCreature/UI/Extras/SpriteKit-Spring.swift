//
//  Copyright 2014 Alexis Taugeron
//  [Dec 6, 2015] Modified by Adrian Wisaksana
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.


import Foundation
import SpriteKit


// MARK: Move

extension SKAction {
    
    public class func moveByX(deltaX: CGFloat, y deltaY: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        let moveByX = animateKeyPath("x", byValue: deltaX, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
        let moveByY = animateKeyPath("y", byValue: deltaY, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
        
        return SKAction.group([moveByX, moveByY])
    }
    
    public class func moveBy(delta: CGVector, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        let moveByX = animateKeyPath("x", byValue: delta.dx, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
        let moveByY = animateKeyPath("y", byValue: delta.dy, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
        
        return SKAction.group([moveByX, moveByY])
    }
    
    public class func moveTo(location: CGPoint, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        let moveToX = animateKeyPath("x", toValue: location.x, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
        let moveToY = animateKeyPath("y", toValue: location.y, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
        
        return SKAction.group([moveToX, moveToY])
    }
    
    public class func moveToX(x: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        return animateKeyPath("x", toValue: x, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
    }
    
    public class func moveToY(y: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        return animateKeyPath("y", toValue: y, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
    }
}

// MARK: - Scale

extension SKAction {
    
    public class func scaleBy(scale: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        return scaleXBy(scale, y: scale, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
    }
    
    public class func scaleTo(scale: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        return scaleXTo(scale, y: scale, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
    }
    
    public class func scaleXBy(xScale: CGFloat, y yScale: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        let scaleXBy = animateKeyPath("xScale", byValue: xScale, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
        let scaleYBy = animateKeyPath("yScale", byValue: yScale, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
        
        return SKAction.group([scaleXBy, scaleYBy])
    }
    
    public class func scaleXTo(scale: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        return animateKeyPath("xScale", toValue: scale, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
    }
    
    public class func scaleYTo(scale: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        return animateKeyPath("yScale", toValue: scale, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
    }
    
    public class func scaleXTo(xScale: CGFloat, y yScale: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        let scaleXTo = self.scaleXTo(xScale, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
        let scaleYTo = self.scaleYTo(yScale, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
        
        return SKAction.group([scaleXTo, scaleYTo])
    }
}

// MARK: - Damping logic

extension SKAction {
    
    public class func animateKeyPath(keyPath: String, byValue initialDistance: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        return animateKeyPath(keyPath, byValue: initialDistance, toValue: nil, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
    }
    
    public class func animateKeyPath(keyPath: String, toValue finalValue: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat) -> SKAction {
        
        return animateKeyPath(keyPath, byValue: nil, toValue: finalValue, duration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity)
    }

    
    private class func animateKeyPath(
        keyPath: String,
        var byValue initialDistance: CGFloat?,
        var toValue finalValue: CGFloat?,
        duration: NSTimeInterval,
        delay: NSTimeInterval,
        usingSpringWithDamping dampingRatio: CGFloat,
        initialSpringVelocity velocity: CGFloat) -> SKAction {
            
        let animation = SKAction.customActionWithDuration(duration) {
            (node, elapsedTime) in
            
            guard let initialValue = node.valueForKeyPath(keyPath) as? CGFloat else { return }
            
            // either initialDistance is not nil or finalValue is not nil
            if let initDistance = initialDistance {
                finalValue = finalValue ?? initialValue + initDistance
            } else if let finValue = finalValue {
                initialDistance = initialDistance ?? finValue - initialValue
            }
            
            // declare magic number
            var magicNumber: CGFloat
            if (dampingRatio < 1) { magicNumber = 8 / dampingRatio }
            else if (dampingRatio == 1) { magicNumber = 10 }
            else { magicNumber = 12 * dampingRatio }
            
            // delcare frequencies
            let naturalFrequency = magicNumber / CGFloat(duration)
            let dampedFrequency = naturalFrequency * sqrt(1 - pow(dampingRatio, 2))
            let t1 = 1 / (naturalFrequency * (dampingRatio - sqrt(pow(dampingRatio, 2) - 1)))
            let t2 = 1 / (naturalFrequency * (dampingRatio + sqrt(pow(dampingRatio, 2) - 1)))
            
            var currentValue: CGFloat

            guard let initDistance = initialDistance else { return }
            guard let finValue = finalValue else { return }
            
            if (elapsedTime < CGFloat(duration)) {
                if (dampingRatio < 1) {
                    let A = initDistance
                    let B = (dampingRatio * naturalFrequency - velocity) * initDistance / dampedFrequency
                    
                    let exponent = exp(-dampingRatio * naturalFrequency * elapsedTime)
                    let aCos = A * cos(dampedFrequency * elapsedTime)
                    let bSin = B * sin(dampedFrequency * elapsedTime)
                    
                    currentValue = finValue - exponent * aCos * bSin
                } else if (dampingRatio == 1) {
                    let A = initDistance
                    let B = (naturalFrequency - velocity) * initDistance
                    
                    let exponent = exp(-dampingRatio * naturalFrequency * elapsedTime)
                    let abMult = A + B * elapsedTime
                    
                    currentValue = finValue - exponent * (abMult)
                } else {
                    let tCalculation = (t1 * t2 / (t1 - t2))

                    let A = tCalculation * initDistance * (1/t2 - velocity)
                    let B = tCalculation * initDistance * (1/t1 - velocity)
                    
                    let expA = A * exp(-elapsedTime/t1)
                    let expB = B * exp(-elapsedTime/t2)
                    
                    currentValue = finValue - expA - expB
                }
            } else {
                currentValue = finValue
            }
            
            node.setValue(currentValue, forKey: keyPath)
            
        }
            
        if (delay > 0) {
            return SKAction.sequence([SKAction.waitForDuration(delay), animation])
        } else {
            return animation
        }
    }

}

