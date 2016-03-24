//
//  AppDelegate.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import RxSwift
import SpriteKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: - Properties
    
    private var didEnterBackground = false
    
    private var notificationManager: NotificationManager?
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    private var gameManager: GameManager? {
        guard let mainViewController = window?.rootViewController as? MainViewController else { return nil }
        return mainViewController.gameManager
    }
    
    // MARK: - App delegate methods

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // MARK: - Notifications setup
                
        let settings = UIUserNotificationSettings(forTypes: [.Sound, .Badge, .Alert], categories: nil)
        application.registerUserNotificationSettings(settings)
        
        
        
        return true
        
    }

    func applicationWillResignActive(application: UIApplication) {
    
        saveGameManagerData()
    
    }

    func applicationDidEnterBackground(application: UIApplication) {

        saveGameManagerData()
        
        guard let gameManager = gameManager else { return }
        
        self.notificationManager = NotificationManager(gameManager: gameManager)
        
        notificationManager?.cancelAllNotifications()
        notificationManager?.schedulePetNotification()
        
        saveGameManagerData()
        
        didEnterBackground = true
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
        notificationManager?.cancelAllNotifications()
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        guard let mainViewController = window?.rootViewController as? MainViewController else { return }
        guard let view = mainViewController.view as? SKView else { return }
        guard let scene = view.scene as? DashboardScene else { return }
        
        if didEnterBackground {
            scene.didBecomeActive()
            didEnterBackground = false
        }
        
        notificationManager?.cancelAllNotifications()
  
    }

    func applicationWillTerminate(application: UIApplication) {
        
        notificationManager?.schedulePetNotification()
        
        saveGameManagerData()
        
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        guard let categoryString = notification.category else { return }
        guard let category = NotificationManager.Category(rawValue: categoryString) else { return }
        
        // TODO: Refactor category implementation
        switch category {
        case .PetSad:
            notificationManager?.schedulePetNotification()
        case .PetFaint:
            notificationManager?.schedulePetNotification()
        case .Progress:
            break
        }
        
        print("Did receive local notification")
        
    }
    
    // MARK: - Custom methods
    
    private func saveGameManagerData() {
        
        guard let gameManager = gameManager else { return }
        
        gameManager.lastClosedDate = NSDate()
        
        let gameManagerData = NSKeyedArchiver.archivedDataWithRootObject(gameManager)
        defaults.setObject(gameManagerData, forKey: "GameManagerArchive")
        
    }

}

