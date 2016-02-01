//
//  StoreViewController.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/4/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class StoreViewController: UIViewController {

    // MARK: - Properties
    
    weak var gameManager: GameManager?
    
    // MARK: - UI Properties
    
    @IBOutlet var mainView: StoreMainView!
    
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
    
    // MARK: - Actions
    
    @IBAction func onExitButtonTap(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

}

extension StoreViewController: GameManagerHolder {}

extension StoreViewController: UITableViewDelegate {
    
    // MARK: - Cell height
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (mainView.selectedSection == indexPath.section) {
            return 100
        } else {
            return 50
        }
        
    }
    
    // MARK: - Cell spacing header
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        
        return view
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 20
        
    }
    
    // MARK: - Cell selection
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! StoreItemCell
        
        // reset buy button state
        cell.buyButtonState = .Normal
        
        if cell.selectionStatus == true {
            cell.selectionStatus = false
            mainView.selectedSection = nil
        } else {
            cell.selectionStatus = true
            mainView.selectedSection = indexPath.section
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! StoreItemCell
        
        // reset buy button state
        cell.buyButtonState = .Normal
        
        cell.selectionStatus = false
        
    }
    
}

extension StoreViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StoreItemCell") as! StoreItemCell
        
        return cell
        
    }
    
}