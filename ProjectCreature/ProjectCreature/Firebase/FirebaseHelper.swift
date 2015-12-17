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
        case SomeError(NSError)
        case UnexpectedError(message: String)
    }
    
    static var currentUser: User?
    
    // MARK: - User authentication
    
    /** 
    Signs the new user up through the following process:
    1. Creates the user on Firebase
    2. Logs in the new user through password authentication 
    3. Creates user json tree if previous steps are successful
    */
    func signupUser(username username: String, email: String, password: String) -> Observable<User> {
        
        return rootRef.rx_createUser(email, password: password)
            .flatMap { _ -> Observable<User> in
                
                return self.rootRef.rx_authUser(email, password: password)
                    .flatMap { (authData: FAuthData!) -> Observable<User> in
                        
                        let userJson = UserJsonModel(email: email, username: username)
                            .toJSON()
                        
                        let ref = self.usersRef.childByAppendingPath(authData.uid)
                        return ref.rx_setValue(userJson)
                            .map { (firebaseRef: Firebase!) -> User in
                                return User(email: email, username: username, uid: authData.uid)
                            }
                    }
            }
        
    }
    
    func loginUser(email email: String, password: String) -> Observable<User> {
        
        return usersRef.rx_authUser(email, password: password)
            .flatMap { authData in
                return self.fetchUserData(byUID: authData.uid)
            }
    }
    
    func logoutUser() {
        
        rootRef.unauth()
        FirebaseHelper.currentUser = nil
        
    }
    
    // MARK: - User data
    
    func fetchUserData(byUID uid: String) -> Observable<User> {
        
        return create { observer in
            
            self.usersRef
                .childByAppendingPath(uid)
                .observeSingleEventOfType(.Value) {
                    (snapshot: FDataSnapshot!) in
                    
                    guard let userJson = snapshot.value as? JSON else {
                        observer.onError(FirebaseError.ParsingError)
                        return
                    }
                    guard let userJsonModel = UserJsonModel(json: userJson) else {
                        observer.onError(FirebaseError.UnexpectedError(
                            message: "Error creating UserJsonModel"))
                        return
                    }
                    
                    let user = User(uid: uid, model: userJsonModel)
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
                    
                    guard let (uid, jsonModel) = self.parseSnapshotValue(snapshot.value) else {
                        observer.onError(FirebaseError.ParsingError)
                        return
                    }
                    
                    guard let userJsonModel = UserJsonModel(json: jsonModel) else {
                        observer.onError(FirebaseError.UnexpectedError(
                            message: "Error creating UserJsonModel")
                        )
                        return
                    }
                    
                    let user = User(uid: uid, model: userJsonModel)
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
    
    // MARK: - Creature methods
    
    func createCreature(fromCreature creature: Creature) {
        
        let creatureJson = CreatureJsonModel(creature: creature).toJSON()

        creaturesRef
            .childByAppendingPath(String(creature.id.value))
            .setValue(creatureJson)
        
    }
    
    func fetchCreature(fromUser user: User) -> Observable<Creature> {
        
        return create { observer in
            
            self.creaturesRef
                .queryOrderedByChild("ownerUID")
                .queryEqualToValue(user.uid)
                .observeSingleEventOfType(.Value) {
                    (snapshot: FDataSnapshot!) in
                    
                    guard let (id, jsonModel) = self.parseSnapshotValue(snapshot.value) else {
                        observer.onError(FirebaseError.ParsingError)
                        return
                    }
                    
                    guard let creatureJsonModel = CreatureJsonModel(json: jsonModel) else {
                        observer.onError(FirebaseError.UnexpectedError(
                            message: "Error creating CreatureJsonModel")
                        )
                        return
                    }
                    
                    let creature = Creature(id: id, model: creatureJsonModel)
                    observer.onNext(creature)
                    observer.onCompleted()
            }
            
            return NopDisposable.instance
        }
        
    }
}