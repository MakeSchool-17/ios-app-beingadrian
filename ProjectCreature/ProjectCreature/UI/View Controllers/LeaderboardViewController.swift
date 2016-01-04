//
//  LeaderboardViewController.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/4/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class LeaderboardViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var gameManager: GameManager?
    
    // MARK: - UI Properties
    
    @IBOutlet var mainView: LeaderboardMainView!
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // MARK: - Actions

    @IBAction func onExitButtonTap(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    
    }
}

extension LeaderboardViewController: GameManagerHolder {}
