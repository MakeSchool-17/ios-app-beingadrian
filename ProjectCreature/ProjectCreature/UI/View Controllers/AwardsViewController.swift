//
//  AwardsViewController.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/29/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit


class AwardsViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var gameManager: GameManager?
    
    // MARK: - UI Properties
    
    @IBOutlet var mainView: AwardsMainView!
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    private func setup() {
        
        // table view setup
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
    }
    
    // MARK: Actions

    @IBAction func onExitButtonTap(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

}

extension AwardsViewController: GameManagerHolder {}

extension AwardsViewController: UITableViewDelegate {
    
    // MARK: - Cell height
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (indexPath.section == mainView.selectedIndexPath) {
            if mainView.cellIsSelected {
                mainView.cellIsSelected = false
                return 44
            } else {
                mainView.cellIsSelected = true
                return 88
            }
        }
        
        return 44
        
    }
    
    // MARK: - Cell footer
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        
        return view
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 15
        
    }
    
    // MARK: - Cell selection
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        mainView.selectedIndexPath = indexPath.section
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
}

extension AwardsViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AwardCell") as! AwardCell
        
        return cell
        
    }
    
}
