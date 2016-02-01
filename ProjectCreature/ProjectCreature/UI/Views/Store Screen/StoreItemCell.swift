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
    
    // MARK: - UI Properties
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var itemDescription: UILabel!
    
    var selectionStatus: Bool?
    
    var buyButtonState: BuyButtonState = .Normal {
        didSet {
            animateButtonColor(buyButton, color: buyButtonState.color)
            
            guard let item = self.storeItem else { return }
            let priceString = formatNumberToString(item.price)
            self.buyButton.setTitle(priceString, forState: .Normal)
        }
    }
    
    // MARK: - Properties
    
    weak var delegate: StoreBuyButtonDelegate?
    
    var storeItem: StoreItem? {
        didSet {
            guard let item = storeItem else { return }
            
            self.itemTitle.text = item.title
            self.itemDescription.text = item.description
            
            let priceString = formatNumberToString(item.price)
            self.buyButton.setTitle(priceString, forState: .Normal)
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
            self.buyButton.setTitle("Buy", forState: .Normal)
        case .Buy:
            guard let storeItem = self.storeItem else { return }
            delegate?.didTapBuyButton(storeItem)
        }
        
    }
    
    private func animateButtonColor(button: UIButton, color: UIColor) {
        
        UIView.animateWithDuration(0.15) {
            
            button.backgroundColor = color
            
        }
        
    }
    
    /**
     * Formats a number to string.
     *
     * - parameter number: A number of type `Double`.
     * - returns: A string e.g. `1,000`.
     */
    private func formatNumberToString(number: Double) -> String {
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        
        guard let numberString = numberFormatter.stringFromNumber(number) else {
            return ""
        }
        
        return numberString
        
    }

}
