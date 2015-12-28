//
//  UIColor+Extension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/12/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit


extension UIColor {
    
    /**
     * Creates a UIColor based on RGBA values without having to divide them by 255.
     *
     * - parameter r: CGFloat Red value
     * - parameter g: CGFloat Green value
     * - parameter b: CGFloat Blue value
     * - parameter a: CGFloat Alpha value (opacity)
     */
    public class func rgbaColor(r r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)

    }
    
}