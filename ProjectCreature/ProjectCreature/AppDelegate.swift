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

        // insert code here
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
        defer {
            saveGameManagerData()
            didEnterBackground = true
        }
        
        notificationManager?.schedulePetNotification()
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
        notificationManager?.cancelAllNotifications()
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        if didEnterBackground {
            guard let mainViewController = window?.rootViewController as? MainViewController else { return }
            guard let view = mainViewController.view as? SKView else { return }
            guard let scene = view.scene as? DashboardScene else { return }
            scene.didBecomeActive()
            didEnterBackground = false
            
            self.notificationManager = NotificationManager(gameManager: scene.gameManager)
        }
  
    }

    func applicationWillTerminate(application: UIApplication) {
        
        notificationManager?.schedulePetNotification()
        
        saveGameManagerData()
        
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        print("Did receive local notification")
        
    }
    
    // MARK: - Custom methods
    
    private func saveGameManagerData() {
        
        guard let mainViewController = window?.rootViewController as? MainViewController else { return }
        guard let gameManager = mainViewController.gameManager else { return }
        
        let gameManagerData = NSKeyedArchiver.archivedDataWithRootObject(gameManager)
        defaults.setObject(gameManagerData, forKey: "GameManagerArchive")
        
    }

}

