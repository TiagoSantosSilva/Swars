//
//  StarWarsNetwork.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Moya
import RxSwift

protocol StarWarsNetworkProtocol {
    func getStarWarsPersonInformation(with identifier: String) -> Observable<Data>
    func getStarWarsPeople(with identifier: String) -> Observable<Data>
    func getSpeciesInformation(with identifier: String) -> Observable<Data>
}

struct StarWarsNetwork: StarWarsNetworkProtocol {
    
    // MARK: - Dependencies
    
    private let provider: MoyaProvider<StarWarsAPI>
    
    // MARK: - Initializer
    
    init(provider: MoyaProvider<StarWarsAPI>) {
        self.provider = provider
    }
    
    // MARK: - Methods
    
    func getStarWarsPersonInformation(with identifier: String) -> Observable<Data> {
        
        return provider.rx
            .request(.getPerson(id: identifier))
            .debug()
            .filterSuccessfulStatusCodes()
            .retry(3)
            .map { $0.data }
            .asObservable()
    }
    
    func getStarWarsPeople(with identifier: String) -> Observable<Data> {
        return provider.rx
            .request(.getPeoplePage(number: identifier))
            .debug()
            .filterSuccessfulStatusCodes()
            .retry(3)
            .map { $0.data }
            .asObservable()
    }
    
    func getSpeciesInformation(with identifier: String) -> Observable<Data> {
        return provider.rx
            .request(.getSpecies(id: identifier))
            .debug()
            .filterSuccessfulStatusCodes()
            .retry(3)
            .map { $0.data }
            .asObservable()
    }
}
