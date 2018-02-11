//
//  PersonDetailsViewController.swift
//  Swars
//
//  Created by Tiago Santos on 11/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class PersonDetailsViewController: BaseViewController {

    // MARK: - View Model
    
    var personDetailsViewModel: PersonDetailsViewModel?
    
    // MARK: - Data Manager
    
    private lazy var dataManager = {
        return StarWarsDataManager()
    }()
    
    // MARK: - Properties
    
    var personIdentifier: String?
    
    // MARK: - Initializers
    
    convenience init(personIdentifier: String) {
        self.init()
        self.personIdentifier = personIdentifier
        fetchPersonData()
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
    }
    
    internal func fetchPersonData() {
        guard let personIdentifier = personIdentifier else { return }
        
        dataManager.getData(endpoint: "\(StarWarsEndpoints.personUrl)\(personIdentifier)", Person.self) { (result, error) in
            guard error == nil else {
                return
            }
            
            guard let response = result as? Person else {
                return
            }
            
            self.personDetailsViewModel = PersonDetailsViewModel(person: response)
        }
    }
}
