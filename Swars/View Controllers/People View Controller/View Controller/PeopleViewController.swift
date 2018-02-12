//
//  PeopleViewController.swift
//  Swars
//
//  Created by Tiago Santos on 09/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PeopleViewController: BaseViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(PersonCell.self)
        }
    }
    
    // MARK: - Activity Indicator UI View
    
    var activityIndicatorUIView: UIView!
    
    // MARK: - Properties
    
    private let viewControllerTitle = "Star Wars People"
    
    // MARK: - Dispose Bag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View Model
    
    private var viewModel: PeopleViewModelRepresentable!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setups
    
    override func setupViewController() {
        super.setupViewController()
        title = viewControllerTitle
    }
    
    // MARK: - Setups
    
    override func setupViewModel() {
        super.setupViewModel()
        viewModel = PeopleViewModel(dataDependencies: DataDependencies())
        
        displayActivityIndicatorView()
        handleDataSource()
    }
}

extension PeopleViewController: UICollectionViewDelegate {
    
}

extension PeopleViewController {
    func handleDataSource() {
        let sharedDataSource = viewModel.dataSource.asObservable().share()
        subscribeToViewModelDataSource(with: sharedDataSource)
        bindItemsToCollectionView(with: sharedDataSource)
        subscribeToPagination()
        setCollectionViewCellSelectionHandler()
        subscribeToDataSourceEndReaching()
    }
    
    internal func displayActivityIndicatorView() {
        activityIndicatorUIView = UIViewController.displayActivityIndicatorView(onView: self.view)
    }
    
    internal func subscribeToViewModelDataSource(with sharedDataSource: Observable<[PersonCellViewModelRepresentable]>) {
        sharedDataSource.subscribe(onNext: { [weak self] _ in
            guard let activityIndicatorUIView = self?.activityIndicatorUIView else { return }
            UIViewController.removeActivityIndicatorView(activityIndicatorView: activityIndicatorUIView)
        })
    }
    
    internal func bindItemsToCollectionView(with sharedDataSource: Observable<[PersonCellViewModelRepresentable]>) {
        sharedDataSource.catchError { error in
            print(error)
            return Observable.empty()
            }
            .bind(to: collectionView.rx.items(cellIdentifier: PersonCell.identifier, cellType: PersonCell.self)) { (_, model, cell) in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
    }
    
    internal func subscribeToPagination() {
        collectionView.rxNextPageTrigger.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            if $0, !self.viewModel.isLoading, !self.viewModel.didReachEnd.value {
                self.activityIndicatorUIView = UIViewController.displayActivityIndicatorView(onView: self.view)
                self.viewModel.fetchNextPeoplePage()
            }
        }).disposed(by: disposeBag)
    }
    
    internal func setCollectionViewCellSelectionHandler() {
        collectionView.rx.modelSelected(PersonCellViewModel.self)
            .subscribe(onNext: { value in
                let personDetailsViewController = PersonDetailsViewController(personIdentifier: value.personId, dataDependencies: DataDependencies())
                self.navigationController?.pushViewController(personDetailsViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    internal func subscribeToDataSourceEndReaching() {
        viewModel.didReachEnd.asObservable().subscribe(onNext: { [weak self] in
            if $0 {
                guard let `self` = self else { return }
                UIViewController.removeActivityIndicatorView(activityIndicatorView: self.activityIndicatorUIView)
            }
        }).disposed(by: disposeBag)
    }
}


