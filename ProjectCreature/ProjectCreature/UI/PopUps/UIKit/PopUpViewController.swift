//
//  PopUpViewController.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/31/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit
import RxSwift


class PopUpViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    // MARK: - UI Properties
    
    @IBOutlet var mainView: PopUpMainView!
    
    // MARK: - Properties
    
    var gameManager: GameManager?
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    private func setup() {
        
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        
        setupPopUpView()
        
    }
    
    private func setupPopUpView() {
        
        self.mainView.popUpView.backgroundColor = UIColor.whiteColor()
        self.mainView.popUpView.layer.cornerRadius = 23
        self.mainView.popUpView.layer.borderWidth = 6.5
        self.mainView.popUpView.layer.borderColor = UIColor.rgbaColor(
            r: 115, g: 115, b: 115, a: 1).CGColor
        
        self.mainView.delegate = self
        
    }
    
    // MARK: - Show method
    
    func showInView(view: UIView, animated: Bool) {
        
        let viewToAdd = self.view as! PopUpMainView
        view.addSubview(viewToAdd)
        
        if animated {
            self.transitionIn()
        }
        
    }
    
    // MARK: - Transitions
    
    func transitionIn() {
        
        self.mainView.animateIn()
        
    }
    
    func transitionOut() {
        
        self.mainView.animateOut()
        
    }

}

extension PopUpViewController: PopUpMainViewDelegate {
    
    func didTapConfirmButton() {
        
        print("> Did tap confirm button")
        
    }
    
    func didTapCancelButton() {
        
        self.transitionOut()
        
    }
    
}
