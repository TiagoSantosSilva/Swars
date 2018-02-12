//
//  DataDependencies.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Moya

struct DataDependencies: HasNetworkService {
    
    // MARK: - Properties
    
    let networkService: StarWarsNetworkProtocol
    
    // MARK: - Initializer
    
    init() {
        let starWarsAPI = MoyaProvider<StarWarsAPI>()
        networkService = StarWarsNetwork(provider: starWarsAPI)
    }
} 