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
    
    private var didEnterBackground = false

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // MARK: - Firebase setup
        
        Firebase.defaultConfig().persistenceEnabled = true
        
        return true
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        guard let mainViewController = window?.rootViewController as? MainViewController else { return }
        guard let gameManager = mainViewController.gameManager else { return }
        
        let defaults = NSUserDefaults.standardUserDefaults()

        let gameManagerData = NSKeyedArchiver.archivedDataWithRootObject(gameManager)
        defaults.setObject(gameManagerData, forKey: "GameManagerArchive")
        
//        let userData = NSKeyedArchiver.archivedDataWithRootObject(gameManager.user)
//        defaults.setObject(userData, forKey: "UserArchive")
//        
//        let petData = NSKeyedArchiver.archivedDataWithRootObject(gameManager.pet)
//        defaults.setObject(petData, forKey: "PetArchive")
        
        print("> Hit application will terminate")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        didEnterBackground = true
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if didEnterBackground {
            guard let mainViewController = window?.rootViewController as? MainViewController else { return }
            guard let view = mainViewController.view as? SKView else { return }
            guard let scene = view.scene as? DashboardScene else { return }
            scene.didBecomeActive()
            didEnterBackground = false
        }
  
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        

        
    }

}

