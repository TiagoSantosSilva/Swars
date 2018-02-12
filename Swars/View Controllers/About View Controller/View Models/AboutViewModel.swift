//
//  AboutViewModel.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct AboutViewModel {
    
    // MARK: - Section Enum
    
    enum Section: Int {
        
        case developerName
        case developerBirthdate
        
        // MARK: - Properties
        
        var title: String {
            switch self {
            case .developerName: return "Name"
            case .developerBirthdate: return "Birthdate"
            }
        }
        
        var numberOfRows: Int {
            switch self {
            case .developerName:
                return 1
            case .developerBirthdate:
                return 1
            }
        }
        
        static var count: Int {
            return Section.developerBirthdate.rawValue + 1
        }
    }
    
    enum Row: Int {
        
        case developerName
        case developerBirthdate
        
        // MARK: - Properties
        
        var title: String {
            switch self {
            case .developerName: return "Tiago Silva"
            case .developerBirthdate: return "5th June, 1995"
            }
        }
    }
    
    // MARK: -
    
    var numberOfSections: Int {
        return Section.count
    }
    
    var numberOfRows: Int {
        return 1
    }
    
    // MARK: -
    
    func sectionTitle(for index: Int) -> String {
        guard let section = Section(rawValue: index) else {
            fatalError("Unexpected Section")
        }
        
        return section.title
    }
    
    func rowContent(for index: Int) -> String {
        guard let row = Row(rawValue: index) else {
            fatalError("Unexpected Row")
        }
        
        return row.title
    }
}
