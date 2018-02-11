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
    var speciesDataSource: Observable<String> { get }
    
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
    
    var speciesDataSource: Observable<String>
    
    // MARK: - Initializer
    
    init(person: Person, dataDependencies: DependenciesList) {
        self.dataDependencies = dataDependencies
        self.personId = PersonCellViewModel.getPersonId(person: person)
        self.name = PersonCellViewModel.getPersonName(person: person)
        self.vehicleCount = PersonCellViewModel.getVehicleCount(person: person)
        
        // FIXME: - Unwrap this
        let personSpecies = person.species!.first!
        
        // FIXME: - Unwrap this
        let speciesId = PersonCellViewModel.getSpeciesIdFromUrl(with: personSpecies)
        
        // FIXME: - Unwrap this
        speciesDataSource = PersonCellViewModel.fetchPersonSpecies(with: speciesId!, dataDependency: dataDependencies).map {
            $0.name.map {
                String(describing: $0)
                }!
        }
    }
    
    // MARK: - Person Attributes Unwrappers
    // TODO: - Substring the id
    private static func getPersonId(person: Person) -> String {
        guard let personId = person.url else {
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
        guard let personSpecies = person.species?.first else {
            return ""
        }
        
        guard let personSpeciesId = getSpeciesIdFromUrl(with: personSpecies) else {
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
    
    // MARK: - String Handling
    
    private static func getSpeciesIdFromUrl(with url: String) -> String? {
        let urlWithoutLastBar = url.substring(to: url.index(before: url.endIndex))
        guard let speciesId = urlWithoutLastBar.components(separatedBy: "/").last else { return nil }
        return speciesId
    }
}
