//
//  PersonCellViewModel.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol PersonCellViewModelRepresentable {
    var speciesDataSource: Observable<String>? { get }
    
    var personId: String! { get }
    var name: String! { get }
    var vehicleCount: String! { get }
}

struct PersonCellViewModel: PersonCellViewModelRepresentable {
    
    // MARK: - Dependencies
    
    typealias DependenciesList = HasNetworkService
    private var dataDependencies: DependenciesList?
    
    // MARK: - Properties
    
    internal var personId: String!
    internal var name: String!
    internal var species: String!
    internal var vehicleCount: String!
    
    // MARK: - Person Species
    
    var speciesDataSource: Observable<String>?
    
    // MARK: - Initializer
    
    init(person: Person, dataDependencies: DependenciesList) {
        self.dataDependencies = dataDependencies
        self.personId = PersonCellViewModel.getPersonId(person: person)
        self.name = PersonCellViewModel.getPersonName(person: person)
        self.vehicleCount = PersonCellViewModel.getVehicleCount(person: person)
        
        if let personSpecies = person.species?.first {
            let speciesId = personSpecies.identifierFromUrl
            
            if let speciesId = speciesId {
                speciesDataSource = PersonCellViewModel.fetchPersonSpecies(with: speciesId, dataDependency: dataDependencies).map {
                    $0.name.map {
                        String(describing: $0)
                        }!
                }
            }
        }
    }
    
    // MARK: - Person Attributes Unwrappers
    
    private static func getPersonId(person: Person) -> String {
        guard let personUrl = person.url else {
            return ""
        }
        
        guard let personId = personUrl.identifierFromUrl else {
            return ""
        }
        
        return personId
    }
    
    private static func getPersonName(person: Person) -> String {
        guard let personName = person.name else {
            return ""
        }
        return personName
    }
    
    private static func getPersonSpeciesId(person: Person) -> String {
        guard let personSpeciesUrl = person.species?.first else {
            return ""
        }
        
        guard let personSpeciesId = personSpeciesUrl.identifierFromUrl else {
            return ""
        }
        
        return personSpeciesId
    }
    
    private static func getVehicleCount(person: Person) -> String {
        guard let vehicleCount = person.vehicles?.count else {
            return ""
        }
        return String.vehicleCountAsString(vehicleCount: vehicleCount)
    }
    
    
    // MARK: - Networking
    
    static private func fetchPersonSpecies(with identifier: String, dataDependency: DependenciesList) -> Observable<Species> {
        let jsonDecoder = JSONDecoder()
        
        let personSpecies = fetchPersonSpeciesData(with: identifier, dataDependency: dataDependency).map {
            try jsonDecoder.decode(Species.self, from: $0)
        }
        
        return personSpecies
    }
    
    static private func fetchPersonSpeciesData(with identifier: String, dataDependency: DependenciesList) -> Observable<Data> {
        return dataDependency.networkService.getSpeciesInformation(with: identifier)
    }
}
