//
//  PersonDetailsViewModel.swift
//  Swars
//
//  Created by Tiago Santos on 11/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct PersonDetailsViewModel {
    
    // MARK: - Properties
    
    let person: Person
    
    // MARK: -
    
    // MARK: -
    
    var name: String {
        guard let personName = person.name else { return "" }
        return personName
    }
    
    // TODO: - Gender Image
    
    var gender: String {
        guard let personGender = person.gender else { return "" }
        return personGender
    }
    
    var homeWorld: String {
        guard let personHomePlanet = person.homeworld else { return "" }
        return personHomePlanet
    }
    
    // TODO: - Skin Color Image
    
    var skinColor: String {
        guard let personSkinColor = person.skinColor else { return "" }
        return personSkinColor
    }
    
    // TODO: - Vehicle Model
    
    var carList: [String] {
        guard let personCarList = person.vehicles else { return [String]() }
        return personCarList
    }
}
