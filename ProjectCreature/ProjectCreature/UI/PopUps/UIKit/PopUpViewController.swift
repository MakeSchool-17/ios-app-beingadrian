//  PopUpViewController.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/31/16.
//  Created by Adrian Wisaksana on 2/5/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit
import RxSwift


class PopUpViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    // MARK: - UI Properties
    
    var mainView: PopUpMainView!
    
    // MARK: - View did load
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    func setup() {
        
        self.mainView = PopUpMainView()
        self.mainView.frame.size = self.view.frame.size
        
    }
    
    // MARK: - Show method
    
    func showInView(view: UIView, animated: Bool) {
        
        self.viewDidLoad()
        
        view.addSubview(self.mainView)
        
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