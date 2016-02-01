//
//  SettingsViewModel.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/23/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation


struct SettingsSection {
    
    let title: String
    let rows: [SettingsRow]
    
}

struct SettingsRow {
    
    enum RowType {
        case Switch
        case Detail
        
        var cellIdentifier: String {
            switch self {
            case .Switch:   return "SwitchSettingsCell"
            case .Detail:   return "DetailSettingsCell"
            }
        }
    }
    
    let title: String
    let type: RowType
    
}

class SettingsViewModel {
    
    // MARK: - Properties
    
    let sections: [SettingsSection]
    
    // MARK: - Initialization
    
    init() {
        
        let firstSection = SettingsSection(
            title: "Music",
            rows: [
                SettingsRow(title: "Background music", type: .Switch),
                SettingsRow(title: "Sounds", type: .Switch)
            ])
        
        let secondSection = SettingsSection(
            title: "Game",
            rows: [
                SettingsRow(title: "Profile", type: .Detail),
                SettingsRow(title: "Pet", type: .Detail)
            ])
        
        let thirdSection = SettingsSection(
            title: "Extras",
            rows: [
                SettingsRow(title: "About LazyPets", type: .Detail)
            ])
        
        
        self.sections = [firstSection, secondSection, thirdSection]
        
    }
    
    
}