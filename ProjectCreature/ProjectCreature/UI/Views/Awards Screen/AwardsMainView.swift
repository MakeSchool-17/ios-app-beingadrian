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
    
    var selectedIndexPath = 0
    var cellIsSelected = false
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        
        setupTableView()
        
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
