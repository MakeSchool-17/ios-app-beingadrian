//
//  AwardCell.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/2/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class AwardCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var awardNameLabel: UILabel!
    @IBOutlet weak var awardProgressLabel: UILabel!
    @IBOutlet weak var awardImageView: UIImageView!
    @IBOutlet weak var awardDescriptionLabel: UILabel!
    
    var selectionStatus: Bool? = false
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
        
    }
    
}
