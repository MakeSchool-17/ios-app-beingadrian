//
//  SwitchSettingsCell.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/23/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit

class SwitchSettingsCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
        
    }

    private func setup() {
        
        title.font = UIFont(name: "Avenir-Book", size: 17)
        
    }
    
}
