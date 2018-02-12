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
    
    var spinner: UIView!
    
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
    
    // MARK: - Setup View Model
    override func setupViewModel() {
        super.setupViewModel()
        viewModel = PeopleViewModel(dataDependencies: DataDependencies())
        
        // TODO: - Make the Collection View only visible after this is finished.
        
        spinner = UIViewController.displayActivityIndicatorView(onView: self.view)
        let sharedDataSource = viewModel.dataSource.asObservable().share()
        
        sharedDataSource.subscribe(onNext: { [weak self] _ in
            guard let spinner = self?.spinner else { return }
            UIViewController.removeActivityIndicatorView(activityIndicatorView: spinner)
        })
        
        sharedDataSource.catchError { error in
            print(error)
            return Observable.empty()
            }
            .bind(to: collectionView.rx.items(cellIdentifier: PersonCell.identifier, cellType: PersonCell.self)) { (_, model, cell) in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
        
        collectionView.rxNextPageTrigger.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            if $0, !self.viewModel.isLoading, !self.viewModel.didReachEnd.value {
                self.spinner = UIViewController.displayActivityIndicatorView(onView: self.view)
                self.viewModel.isReadyToLoad()
            }
        }).disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(PersonCellViewModel.self)
            .subscribe(onNext: { value in
                let personDetailsViewController = PersonDetailsViewController(personIdentifier: value.personId, dataDependencies: DataDependencies())
                self.navigationController?.pushViewController(personDetailsViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.didReachEnd.asObservable().subscribe(onNext: { [weak self] in
            if $0 {
                guard let `self` = self else { return }
                UIViewController.removeActivityIndicatorView(activityIndicatorView: self.spinner)
            }
        }).disposed(by: disposeBag)
    }
}

extension PeopleViewController: UICollectionViewDelegate {
    
}


