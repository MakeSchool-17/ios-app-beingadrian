//
//  SettingsMainView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/4/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class SettingsMainView: UIView {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
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
        
        // nib registrations
        let switchCellNib = UINib(nibName: "SwitchSettingsCell", bundle: nil)
        let detailCellNib = UINib(nibName: "DetailSettingsCell", bundle: nil)
        tableView.registerNib(switchCellNib, forCellReuseIdentifier: "SwitchSettingsCell")
        tableView.registerNib(detailCellNib, forCellReuseIdentifier: "DetailSettingsCell")
        
        // clear background
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clearColor()
        
    }

}
