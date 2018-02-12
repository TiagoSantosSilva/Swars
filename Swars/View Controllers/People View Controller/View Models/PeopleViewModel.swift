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
    var dataSource: Variable<[PersonCellViewModelRepresentable]> { get }
    var didReachEnd: Variable<Bool> { get }
    
    var isLoading: Bool { get }
    func isReadyToLoad()
}

class PeopleViewModel: PeopleViewModelRepresentable {
    
    private var actualPage = 1
    
    private var count: Int?
    
    var didReachEnd = Variable<Bool>(false)
    
    var isLoading = false
    
    // MARK: - Dependencies
    
    typealias DependenciesList = HasNetworkService
    private var dataDependencies: DependenciesList?
    
    // MARK: - Dispose Bag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Data Source
    
    var dataSource: Variable<[PersonCellViewModelRepresentable]>
    
    // MARK: - Init
    
    init(dataDependencies: DependenciesList) {
        isLoading = true
        self.dataDependencies = dataDependencies
        self.dataSource = Variable<[PersonCellViewModelRepresentable]>([])
        
        self.count = 0
        
        let observableData = PeopleViewModel.fetchStarWarsPeople(with: "\(actualPage)", dataDependency: dataDependencies).map { [weak self] (result) -> [PersonCellViewModel] in
            self?.count = result.count
            
            return result.results.map {
                $0.map {
                    PersonCellViewModel(person: $0, dataDependencies: DataDependencies())
                }
                }!
        }
        
        observableData.subscribe(onNext: { [weak self] in
            self?.dataSource.value = $0
            self?.isLoading = false
        })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Networking
    
    static private func fetchStarWarsPeople(with page: String, dataDependency: DependenciesList) -> Observable<PeoplePage> {
        let jsonDecoder = JSONDecoder()
        
        let peoplePage = fetchStarWarsPeoplePage(with: page, dataDependency: dataDependency).map {
            try jsonDecoder.decode(PeoplePage.self, from: $0)
        }
        
        return peoplePage
    }
    
    static private func fetchStarWarsPeople2(with page: String, dataDependency: DependenciesList) -> Observable<PeoplePage> {
        let jsonDecoder = JSONDecoder()
        
        let peoplePage = fetchStarWarsPeoplePage(with: page, dataDependency: dataDependency).map {
            return try jsonDecoder.decode(PeoplePage.self, from: $0)
            }.subscribe(onNext: {
                print($0)
            })
        
        return Observable<PeoplePage>.empty()
    }
    
    static private func fetchStarWarsPeoplePage(with page: String, dataDependency: DependenciesList) -> Observable<Data> {
        return dataDependency.networkService.getStarWarsPeople(with: page)
    }
    
    func isReadyToLoad() {
        guard let count = count, count != dataSource.value.count, let dataDependency = self.dataDependencies else {
            didReachEnd.value = true
            return
        }
        
        if !isLoading, dataSource.value.count < count {
            isLoading = true
            actualPage += 1
            
            let observableData = PeopleViewModel.fetchStarWarsPeople(with: "\(actualPage)", dataDependency: dataDependency).map {
                $0.results.map {
                    $0.map {
                        PersonCellViewModel(person: $0, dataDependencies: DataDependencies())
                    }
                    }!
            }
            
            observableData.subscribe(onNext: { [weak self] in
                $0.forEach({ self?.dataSource.value.append($0)
                })
                self?.isLoading = false
            })
                .disposed(by: disposeBag)
        }
        
    }
}
