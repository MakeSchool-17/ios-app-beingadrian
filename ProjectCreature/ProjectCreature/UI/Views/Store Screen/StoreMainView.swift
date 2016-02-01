//
//  StoreMainView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/4/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class StoreMainView: UIView {

    // MARK: - Properties
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedSection: Int? 
    
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
        let storeItemCellNib = UINib(nibName: "StoreItemCell", bundle: nil)
        tableView.registerNib(storeItemCellNib, forCellReuseIdentifier: "StoreItemCell")
        
        // clear background
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clearColor()
    }

}
