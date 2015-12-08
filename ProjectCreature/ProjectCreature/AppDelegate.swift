//
//  AppDelegate.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import SpriteKit
import RxSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let disposeBag = DisposeBag()
        
        // Parse setup
        
        Parse.enableLocalDatastore()
        
        let applicationId = "PBf2QMcCJkBiQ2zxktGr5NSHkUarsaYNgzmhVNjB"
        let clientKey = "4prrsitPiS5HiTrr9Nby3dn6UOaESatTLIOx0NVJ"
        Parse.setApplicationId(applicationId, clientKey: clientKey)
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        // register subclasses
        Creature.registerSubclass()
        
        // force Parse login
        if let currentUser = PFUser.currentUser() {
            print("> Already logged in as \(currentUser.username)")
        } else {
            PFUser.rx_logInWithUsernameInBackground("beingadrian", password: "test")
                .subscribe(
                    onNext: { (user) -> Void in
                        print("> Logged in as \(user?.username)")
                    },
                    onError: { (error) -> Void in
                        print("> Error logging in user: \(error)")
                    },
                    onCompleted: { () -> Void in
                        print("> Completed logging in user")
                    },
                    onDisposed: { () -> Void in
                        print("> Dispose log in subscription")
                })
                .addDisposableTo(disposeBag)
        }
        
        return true
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

