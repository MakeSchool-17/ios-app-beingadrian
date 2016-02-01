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
    
    var viewModel: SettingsViewModel!
    
    @IBOutlet var mainView: SettingsMainView!
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    private func setup() {
        
        self.viewModel = SettingsViewModel()
        
        // table view setups
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
    }
    
    // MARK: - Actions

    @IBAction func onExitButtonTap(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    
    }
}

extension SettingsViewController: GameManagerHolder {}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
        
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        
        header.textLabel!.font = UIFont(name: "Avenir-LightOblique", size: 15)
        
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return viewModel.sections.count
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.sections[section].rows.count
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return viewModel.sections[section].title
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = viewModel.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        
        switch row.type {
        case .Switch:
            let cell = tableView.dequeueReusableCellWithIdentifier(row.type.cellIdentifier) as! SwitchSettingsCell
            cell.title.text = row.title
            return cell
        case .Detail:
            let cell = tableView.dequeueReusableCellWithIdentifier(row.type.cellIdentifier) as! DetailSettingsCell
            cell.title.text = row.title
            return cell
        }
        
    }
    
}

