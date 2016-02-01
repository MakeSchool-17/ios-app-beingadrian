//
//  LeaderboardMainView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/4/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class LeaderboardMainView: UIView {
    
    // MARK: - Property
    
    @IBOutlet weak var navigationBar: UINavigationBar!

    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        
        setup()
        
    }
    
    private func setup() {
        
        // navigation bar
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = nil
        navigationBar.translucent = true
        
        // navigation title
        navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "Avenir-HeavyOblique", size: 18)!,
            NSForegroundColorAttributeName: UIColor.darkGrayColor()]
        
    }

}
