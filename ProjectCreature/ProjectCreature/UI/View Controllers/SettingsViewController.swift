//
//  SettingsViewController.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/4/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {

    // MARK: - Properties
    
    weak var gameManager: GameManager?
    
    // MARK: - UI Properties
    
    @IBOutlet var mainView: SettingsMainView!
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Actions

    @IBAction func onExitButtonTap(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    
    }
}

extension SettingsViewController: GameManagerHolder {}
