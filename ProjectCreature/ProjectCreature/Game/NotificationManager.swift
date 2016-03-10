//
//  NotificationManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 3/1/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation
import UIKit


class NotificationManager {

    enum Category: String {
        case Pet = "PET"
        case Progress = "PROGRESS"
        
    }
    
    enum PetState {
        case Sad
        case Faint
    }
    
    // MARK: - Properties
    
    private let gameManager: GameManager
    
    // MARK: - Initialization
    
    init(gameManager: GameManager) {
        
        self.gameManager = gameManager
        
    }
    
    // MARK: - Methods
    
    func cancelAllNotifications() {
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
    }
    
    // MARK: - Notification creation methods
    
    func scheduleProgressNotification(forDate fireDate: NSDate) {
        
        let messages = [
            "Check out your walking report for today, \(gameManager.user.username)!",
            "That's some good walking today, \(gameManager.user.username)."
        ]
        
        let alertBody = chooseRandomMessage(fromMessages: messages)
        
        let notification = UILocalNotification()
        notification.alertBody = alertBody
        notification.alertAction = "check it out"
        notification.fireDate = fireDate
        notification.category = Category.Progress.rawValue
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    func schedulePetNotification() {
        
        let percentage = gameManager.petManager.pet.hp.value / gameManager.petManager.pet.hpMax.value
        
        var message: String?
        var date: NSDate?
        
        switch percentage {
        case 0.6...1.0:
            message = createMessage(.Sad)
            date = calculatePetSadnessDate()
        case 0..<0.6:
            message = createMessage(.Faint)
            date = calculatePetFaintDate()
        default:
            break
        }
        
        guard let alertBody = message, let fireDate = date else { return }
        
        let notification = UILocalNotification()
        notification.alertBody = alertBody
        notification.alertAction = "open"
        notification.fireDate = fireDate
        notification.category = Category.Pet.rawValue
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    // MARK: - Convenience methods
    
    private func chooseRandomMessage(fromMessages messages: [String]) -> String {
        
        let countUInt32 = UInt32(messages.count)
        let randomNumber = Int(arc4random_uniform(countUInt32))
        
        return messages[randomNumber]
        
    }
    
    private func createMessage(state: PetState) -> String {
        
        let petName = gameManager.petManager.pet.name.value
        
        let sadStateMessages = [
            "\(petName) is sad :(",
            "\(petName) wants your attention :(",
            "Oh no! \(petName) is hungry!"
        ]
        
        let faintStateMessages = [
            "Oh no! \(petName) is going to faint! Help!",
            "\(petName) needs your help now :(",
            "\(petName) is very very sad now.. Please help \(petName) :(",
        ]
        
        switch state {
        case .Sad:
            return chooseRandomMessage(fromMessages: sadStateMessages)
        case .Faint:
            return chooseRandomMessage(fromMessages: faintStateMessages)
        }
        
    }
    
    private func calculatePetSadnessDate() -> NSDate {
        
        let pet = gameManager.petManager.pet
        let amount = pet.hp.value - (pet.hpMax.value * 0.6)

        let timeInterval = NSTimeInterval(amount / gameManager.petManager.hpDecreasePerHour) * 60 * 60
        
        print("> Seconds: \(timeInterval)")
        
        return NSDate(timeIntervalSinceNow: timeInterval)

    }
    
    private func calculatePetFaintDate() -> NSDate {
        
        let pet = gameManager.petManager.pet
        let amount = pet.hp.value - (pet.hpMax.value * 0.05)
        
        let timeInterval = NSTimeInterval(amount / gameManager.petManager.hpDecreasePerHour)
        
        return NSDate(timeIntervalSinceNow: timeInterval)
        
    }
    
}