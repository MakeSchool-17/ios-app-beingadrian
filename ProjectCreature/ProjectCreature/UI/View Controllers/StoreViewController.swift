//
//  StoreViewController.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/4/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit
import RxSwift


class StoreViewController: UIViewController {

    var disposeBag = DisposeBag()
    
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
        
        let sampleItem = StoreItem(
            title: "Sample item",
            description: "Description of sample item",
            price: 10_000,
            image: UIImage())
        
        cell.storeItem = sampleItem
        
        cell.delegate = self
        
        return cell
        
    }
    
}

extension StoreViewController: StoreBuyButtonDelegate {
    
    func didTapBuyButton(storeItem: StoreItem) {
        
        guard let popUpView = NSBundle.mainBundle()
            .loadNibNamed("PopUpView", owner: self, options: nil).first as? PopUpView
        else { return }
        
        guard let storePopUpView = NSBundle.mainBundle()
            .loadNibNamed("StorePopUpView", owner: self, options: nil).first as? StorePopUpView
        else { return }
        
        popUpView.popUp = storePopUpView
        
        popUpView.transitionInView(self.view)
        
    }
    
}

extension StoreViewController: PopUpControllerDelegate {
    
    func didConfirmBuyingFood(item: StoreItem) {
        
        let food = Food(name: item.title, hpValue: 30)
        gameManager?.didBuyFood(food)
            .subscribe(
                onNext: { (food) -> Void in
                    // send success message
                    print("> Did buy: \(food)")
                },
                onError: { (error) -> Void in
                    print("> Error buying item: \(error)")
                },
                onCompleted: nil,
                onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
    
}

