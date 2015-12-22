//
//  RxCompliant.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/21/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import RxSwift


protocol RxCompliant: class {
    
    var disposeBag: DisposeBag { get set }
    
    func cleanDisposeBag()
    
}

extension RxCompliant {
    
    func cleanDisposeBag() {
        
        self.disposeBag = DisposeBag()
        
    }
    
}