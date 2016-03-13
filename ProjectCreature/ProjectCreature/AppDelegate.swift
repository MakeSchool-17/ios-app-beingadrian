//
//  AppDelegate.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import RxSwift
import Firebase
import SpriteKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: - Properties
    
    private var didEnterBackground = false
    
    private var notificationManager: NotificationManager?
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    // MARK: - App delegate methods

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // MARK: - Firebase setup
        
        Firebase.defaultConfig().persistenceEnabled = true
        
        // request for notification settings
        
        let settings = UIUserNotificationSettings(forTypes: [.Sound, .Badge, .Alert], categories: nil)
        application.registerUserNotificationSettings(settings)
        
        return true
        
    }

    func applicationWillResignActive(application: UIApplication) {

        
        
    }

    func applicationDidEnterBackground(application: UIApplication) {

        saveGameManagerData()
        
        notificationManager?.schedulePetNotification()
        
        recordApplicationClosedDate()
        
        didEnterBackground = true
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
        notificationManager?.cancelAllNotifications()
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        guard let mainViewController = window?.rootViewController as? MainViewController else { return }
        guard let view = mainViewController.view as? SKView else { return }
        guard let scene = view.scene as? DashboardScene else { return }
        
        self.notificationManager = NotificationManager(gameManager: scene.gameManager)
        
        if didEnterBackground {
            let lastClosedDate = defaults.objectForKey("LastClosedDate") as? NSDate
            scene.didBecomeActive(lastClosedDate)
            didEnterBackground = false
        }
        
        notificationManager?.cancelAllNotifications()
  
    }

    func applicationWillTerminate(application: UIApplication) {
        
        notificationManager?.schedulePetNotification()
        
        saveGameManagerData()
        
        recordApplicationClosedDate()
        
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        guard let categoryString = notification.category else { return }
        guard let category = NotificationManager.Category(rawValue: categoryString) else { return }
        
        // TODO: Refactor category implementation
        switch category {
        case .PetSad:
            break
        case .PetFaint:
            break
        case .Progress:
            break
        }
        
        notificationManager?.schedulePetNotification()
        
        print("Did receive local notification")
        
    }
    
    // MARK: - Custom methods
    
    private func recordApplicationClosedDate() {
        
        defaults.setObject(NSDate(), forKey: "LastClosedDate")
        
    }
    
    private func saveGameManagerData() {
        
        guard let mainViewController = window?.rootViewController as? MainViewController else { return }
        guard let gameManager = mainViewController.gameManager else { return }
        
        let gameManagerData = NSKeyedArchiver.archivedDataWithRootObject(gameManager)
        defaults.setObject(gameManagerData, forKey: "GameManagerArchive")
        
    }

}

