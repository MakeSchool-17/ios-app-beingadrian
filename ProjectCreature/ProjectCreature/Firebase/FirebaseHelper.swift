//
//  FirebaseHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/14/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift
import Firebase


typealias JSON = [String: AnyObject]

class FirebaseHelper {
    
    private var disposeBag = DisposeBag()
    
    // MARK: - References
    
    var rootRef = Firebase(url: "https://creature.firebaseio.com")
    
    var usersRef: Firebase {
        return rootRef.childByAppendingPath("users")
    }
    
    var creaturesRef: Firebase {
        return rootRef.childByAppendingPath("creatures")
    }
    
    var connectedRef: Firebase {
        return rootRef.childByAppendingPath(".info/connected")
    }
    
    // MARK: - Properties
    
    enum FirebaseError: ErrorType {
        case NoConnection
        case ParsingError
        case UnexpectedError(message: String)
    }
    
    // MARK: - User
    
    static var currentUser: User?
    
    // MARK: - User authentication methods
    
    func signupUser(username username: String, email: String, password: String) -> Observable<User> {
        
        return create { observer in
            
            self.rootRef.createUser(email, password: password) {
                (error, result) in
                
                if let error = error {
                    // an error occured
                    print("> Error signing up: \(error)")
                    observer.onError(error)
                } else {
                    // successfully signed up on firebase
                    let userRef = self.usersRef.childByAutoId()
                    let userJsonStruct = UserJsonModel(
                        email: email,
                        username: username)
                    
                    // create json tree for user
                    userRef.setValue(userJsonStruct.toJSON()) {
                        (err, firebaseRef) in
                        
                        if let error = error {
                            observer.onError(error)
                        } else {
                            let user = User(
                                email: email,
                                username: username,
                                id: firebaseRef.key)
                            
                            observer.onNext(user)
                            observer.onCompleted()
                        }
                    }
                }
            }
            
            return NopDisposable.instance
        }
        
    }
    
    func loginUser(email email: String, password: String) {
        
        rootRef.authUser(email, password: password) {
            (error, authData) in
            
            print("> Error logging in user: \(error)")
            print("> Login auth data: \(authData)")
        }
        
    }
    
    func loginUser(username username: String, password: String) {

        
    }
    
    func logoutUser() {
        
        
        
    }
    
    // MARK: - User methods
    
    func fetchUser(byEmail email: String) -> Observable<User> {
        
        return create { observer in
        
            self.usersRef
                .queryOrderedByChild("email")
                .queryEqualToValue(email)
                .observeSingleEventOfType(.Value) {
                    (snapshot: FDataSnapshot!) in
                    
                    guard let (key, value) = self.parseSnapshotValue(snapshot.value) else {
                        observer.onError(FirebaseError.ParsingError)
                        return
                    }
                    
                    guard let userJsonModel = UserJsonModel(json: value) else {
                        observer.onError(FirebaseError.UnexpectedError(
                            message: "Error creating UserJsonModel")
                        )
                        return
                    }
                    
                    let user = User(id: key, model: userJsonModel)
                    observer.onNext(user)
                    observer.onCompleted()
            }
            
            return NopDisposable.instance
        }

    }
    
    func fetchUserData(byUsername username: String) -> Observable<User> {
        
        return create { observer in
            
            self.usersRef
                .queryOrderedByChild("username")
                .queryEqualToValue(username)
                .observeSingleEventOfType(.Value) {
                    (snapshot: FDataSnapshot!) in
                    
                    guard let (key, value) = self.parseSnapshotValue(snapshot.value) else {
                        observer.onError(FirebaseError.ParsingError)
                        return
                    }
                    
                    guard let userJsonModel = UserJsonModel(json: value) else {
                        observer.onError(FirebaseError.UnexpectedError(
                            message: "Error creating UserJsonModel")
                        )
                        return
                    }
                    
                    let user = User(id: key, model: userJsonModel)
                    observer.onNext(user)
                    observer.onCompleted()
            }
            
            return NopDisposable.instance
        }
    
    }
    
    /**
    Converts a snapshot value to return a tuple of the key and JSON mode.
    Returns nil if casting fails.
    
    - parameter value: AnyObject The snapshot value e.g. `snapshot.value`.
    - returns: A tuple of the key (which is usually the ID) and the JSON model.
     
    JSON structure:
     
        { "id" = {
            "email" = ""
            "username" = ""
            "cash" = ""
            }
        }
    */
    func parseSnapshotValue(value: AnyObject) -> (String, JSON)? {
        
        guard let initialDict = value as? Dictionary<String, JSON> else { return nil }
        guard let key = initialDict.keys.first else { return nil }
        guard let value = initialDict.values.first else { return nil }
        
        return (key, value)
        
    }
    
    // MARK: - Creature meethods
    
    func createCreature(creature: Creature) {
        
        
        
    }
    
}