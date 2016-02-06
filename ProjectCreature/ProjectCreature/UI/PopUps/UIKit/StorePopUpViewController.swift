//  PopUpViewController.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/31/16.
//  Created by Adrian Wisaksana on 2/5/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit
import RxSwift


class StorePopUpViewController: PopUpViewController {
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    weak var delegate: PopUpControllerDelegate?
    
    var storeItem: StoreItem?
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func setup() {
        
        self.mainView = StorePopUpMainView()
        
    }
    
    // MARK: - Tap gesture actions
    
    func setupButtonTargets() {
        
        guard let popUpView = self.mainView.popUpView as? StorePopUpView else { return }
        
        popUpView.confirmButton.addTarget(self,
            action: "onConfirmButtonTap:", forControlEvents: .TouchUpInside)
        popUpView.cancelButton.addTarget(self,
            action: "onCancelButtonTap:", forControlEvents: .TouchUpInside)
        
    }
    
    func onConfirmButtonTap(sender: UIButton) {
        
        guard let item = self.storeItem else { return }
        
        delegate?.didConfirmBuyingFood(item)
        
        self.transitionOut()
        
    }
    
    func onCancelButtonTap(sender: UIButton) {
        
        self.transitionOut()
        
    }
    
}

extension StorePopUpViewController: PopUpMainViewDelegate {
    
    func didTapConfirmButton() {
        
        guard let item = self.storeItem else { return }
        
        delegate?.didConfirmBuyingFood(item)
        
        self.transitionOut()
        
    }
    
    func didTapCancelButton() {
        
        self.transitionOut()
        
    }
    
}