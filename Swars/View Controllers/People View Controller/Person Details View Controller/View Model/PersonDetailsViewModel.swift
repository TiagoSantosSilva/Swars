//
//  PersonDetailsViewModel.swift
//  Swars
//
//  Created by Tiago Santos on 11/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol PersonDetailsViewModelRepresentable {
    var person: Person? { get set }
    var gender: String { get }
    var name: String { get }
    var homeWorld: String? { get }
    var skinColor: String { get }
    var carList: [String]? { get }
}

class PersonDetailsViewModel: PersonDetailsViewModelRepresentable {
    
    // MARK: - Dispatch Group
    
    let dispatchGroup = DispatchGroup()
    
    // MARK: - Data Manager
    
    private var dataManager: StarWarsDataManager?
    
    // MARK: - Delegate
    
    private var delegate: PersonDetailsViewControllerDelegate?
    
    // MARK: - Properties
    
    var person: Person? {
        didSet {
            fetchHomeworld()
            fetchCarList()
        }
    }
    
    // MARK: -
    
    var name: String {
        guard let personName = person?.name else { return "" }
        return personName
    }
    
    // MARK: -
    
    var gender: String {
        guard let personGender = person?.gender else { return "" }
        return personGender
    }
    
    // MARK: -
    
    private(set) var homeWorld: String?
    
    // MARK: -
    
    var skinColor: String {
        guard let personSkinColor = person?.skinColor else { return "" }
        return personSkinColor.capitalized
    }
    
    // MARK: -
    
    private(set) var carList: [String]?
    
    // MARK: - Initializer
    
    init(dataManager: StarWarsDataManager, delegate: PersonDetailsViewControllerDelegate) {
        self.dataManager = dataManager
        self.delegate = delegate
    }
    
    // MARK: - Networking
    
    private func fetchHomeworld() {
        guard let person = person else { return }
        guard let homeWorldIdentifier = person.homeworld?.identifierFromUrl else { return }
        
        dataManager?.getData(endpoint: "\(StarWarsEndpoints.planetEndpoint)\(homeWorldIdentifier)", Planet.self, completion: { (result, error) in
            guard error == nil else {
                return
            }
            
            guard let planet = result as? Planet else {
                return
            }
            
            self.homeWorld = planet.name
            self.delegate?.didFetchHomeWorld()
        })
    }
    
    private func fetchCarList() {
        guard let person = person else { return }
        guard let personVehicles = person.vehicles else { return }
        carList = [String]()
        
        dispatchGroup.enter()
        
        fetchVehicles(personVehicles)
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: .main) {
            self.delegate?.didFetchCarList()
        }
    }
    
    private func fetchVehicles(_ personVehicles: [String]) {
        for vehicleUrl in personVehicles {
            dispatchGroup.enter()
            guard let vehicleIdentifier = vehicleUrl.identifierFromUrl else { return }
            
            dataManager?.getData(endpoint: "\(StarWarsEndpoints.vehicleEndpoint)\(vehicleIdentifier)", Vehicle.self, completion: { (result, error) in
                guard error == nil else {
                    return
                }
                
                guard let vehicle = result as? Vehicle else {
                    return
                }
                
                guard let vehicleName = vehicle.name else {
                    return
                }
                
                self.carList?.append(vehicleName)
                self.dispatchGroup.leave()
            })
        }
    }
}
