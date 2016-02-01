//
//  AwardsMainView.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/1/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class AwardsMainView: UIView {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var selectedSection: Int?
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        
        setup()
        
    }
    
    private func setup() {
        
        setupTableView()
        
        // navigation bar
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = nil
        navigationBar.translucent = true
        
        // navigation title
        navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "Avenir-HeavyOblique", size: 18)!,
            NSForegroundColorAttributeName: UIColor.darkGrayColor()]
        
    }
    
    private func setupTableView() {
        
        // table view settings
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clearColor()
        
        // registe nibs
        let awardCellNib = UINib(nibName: "AwardCell", bundle: nil)
        tableView.registerNib(awardCellNib, forCellReuseIdentifier: "AwardCell")
        
    }
    
}
