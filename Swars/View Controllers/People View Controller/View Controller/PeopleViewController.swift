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
        
        viewModel.dataSource.catchError { error in
            print(error)
            return Observable.empty()
            }
            .bind(to: collectionView.rx.items(cellIdentifier: PersonCell.identifier, cellType: PersonCell.self)) { (_, model, cell) in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(PersonCellViewModel.self)
            .subscribe(onNext: { value in
                let personDetailsViewController = PersonDetailsViewController(personIdentifier: value.personId, dataDependencies: DataDependencies())
                self.navigationController?.pushViewController(personDetailsViewController, animated: true)
            })
        .disposed(by: disposeBag)
    }
}

extension PeopleViewController: UICollectionViewDelegate {

}
