//
//  UIColor+Extension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/12/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//


extension UIColor {
    
    public class func rgbaColor(r r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    
        return UIColor(
            red: r/255,
            green: g/255,
            blue: b/255,
            alpha: a)

    }
    
}