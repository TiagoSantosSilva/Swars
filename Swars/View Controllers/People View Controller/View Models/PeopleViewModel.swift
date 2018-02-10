//
//  PeopleViewModel.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol PeopleViewModelRepresentable {
    var dataSource: Observable<[PersonCellViewModelRepresentable]> { get }
}

class PeopleViewModel: PeopleViewModelRepresentable {
    
    // MARK: - Dependencies
    
    typealias DependenciesList = HasNetworkService
    private var dataDependencies: DependenciesList?
    
    // MARK: - Dispose Bag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - People Data
    
    private var peopleData: [PersonCellViewModelRepresentable]?
    
    // MARK: - Data Source
    
    var dataSource: Observable<[PersonCellViewModelRepresentable]>
    
    // MARK: - Init
    
    init(dataDependencies: DependenciesList) {
        self.dataDependencies = dataDependencies
        self.peopleData = [PersonCellViewModelRepresentable]()
        
        dataSource = PeopleViewModel.fetchStarWarsPeople(with: "1", dataDependency: dataDependencies).map {
            $0.results.map {
                $0.map(PersonCellViewModel.init)
                }!
        }
    }
    
    static private func fetchStarWarsPeople(with page: String, dataDependency: DependenciesList) -> Observable<PeoplePage> {
        
        let jsonDecoder = JSONDecoder()
        
        let peoplePage = fetchStarWarsPeoplePage(with: page, dataDependency: dataDependency).map {
            try jsonDecoder.decode(PeoplePage.self, from: $0)
        }
        
        return peoplePage
    }
    
    static private func fetchStarWarsPeoplePage(with page: String, dataDependency: DependenciesList) -> Observable<Data> {
        return dataDependency.networkService.getStarWarsPeople(with: page)
    }
}
