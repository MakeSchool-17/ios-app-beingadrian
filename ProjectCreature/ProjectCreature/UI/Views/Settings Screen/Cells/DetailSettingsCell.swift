//
//  DetailSettingsCell.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/23/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class DetailSettingsCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var title: UILabel!
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()

    }
    
    private func setup() {
        
        title.font = UIFont(name: "Avenir-Book", size: 17)
        
    }
    
}
