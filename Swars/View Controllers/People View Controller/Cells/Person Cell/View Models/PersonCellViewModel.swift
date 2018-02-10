//
//  PersonCellViewModel.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation


protocol PersonCellViewModelRepresentable {
    var personId: String { get }
    var name: String { get }
    var species: String { get }
    var vehicleCount: String { get }
}

struct PersonCellViewModel: PersonCellViewModelRepresentable {
    
    let personId: String
    let name: String
    let species: String
    let vehicleCount: String
    
    init(person: Person) {
        personId = person.personId
        name = person.name.capitalized
        species = person.species.capitalized
        vehicleCount = person.vehicleCount.capitalized
    }
}
