//
//  StoreItemCell.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/23/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {

    enum BuyButtonState {
        
        case Normal
        case Buy
        
        var color: UIColor {
            switch self {
            case .Normal:
                return UIColor.lightGrayColor()
            case .Buy:
                return UIColor.rgbaColor(r: 71, g: 216, b: 178, a: 1)
            }
        }
        
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var itemDescription: UILabel!
    
    var selectionStatus: Bool?
    
    var buyButtonState: BuyButtonState = .Normal {
        didSet {
            animateButtonColor(buyButton, color: buyButtonState.color)
        }
    }
    
    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
        
    }
    
    private func setup() {
        
        // rounded button
        buyButton.layer.cornerRadius = 5
        buyButton.clipsToBounds = true
        
    }
    
    // MARK: - Buy button
    
    @IBAction func onBuyButtonTapped(sender: UIButton) {
        
        switch buyButtonState {
        case .Normal:
            buyButtonState = .Buy
        case .Buy:
            // purchase itme
            break
        }
        
    }
    
    private func animateButtonColor(button: UIButton, color: UIColor) {
        
        UIView.animateWithDuration(0.15) {
            
            button.backgroundColor = color
            
        }
        
    }

}
