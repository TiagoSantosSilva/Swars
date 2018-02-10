//
//  AboutViewModel.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct AboutViewModel {
    
    // MARK: - Properties
    
    private let developerName = ["Name": "Tiago Silva"]
    
    private let developerBirthdate = ["Birthdate": "5th June, 1995"]
    
    var developerInformations: [[String: String]] {
        return [developerName, developerBirthdate]
    }
    
    // MARK: -
    
    var numberOfSections: Int {
        return developerInformations.count
    }
    
    var numberOfRows: Int {
        return 1
    }
    
    // MARK: -
    
    func information(for index: Int) -> [String: String] {
        return developerInformations[index]
    }
}
