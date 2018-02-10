//
//  PersonCellViewModel.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation


protocol PersonCellViewModelRepresentable {
    var personId: String! { get }
    var name: String! { get }
    var species: String! { get }
    var vehicleCount: String! { get }
}

struct PersonCellViewModel: PersonCellViewModelRepresentable {
    
    internal var personId: String!
    internal var name: String!
    internal var species: String!
    internal var vehicleCount: String!
    
    init(person: Person) {
        self.personId = getPersonId(person: person)
        self.name = getPersonName(person: person)
        self.species = getPersonSpecies(person: person)
        self.vehicleCount = getVehicleCount(person: person)
    }
    
    // TODO: - Substring the id
    private func getPersonId(person: Person) -> String {
        guard let personId = person.url else {
            return ""
        }
        return personId
    }
    
    private func getPersonName(person: Person) -> String {
        guard let personName = person.name else {
            return ""
        }
        return personName
    }
    
    private func getPersonSpecies(person: Person) -> String {
        guard let personSpecies = person.species?.first else {
            return ""
        }
        return personSpecies
    }
    
    private func getVehicleCount(person: Person) -> String {
        guard let vehicleCount = person.vehicles?.count else {
            return ""
        }
        return String(describing: vehicleCount)
    }
}
