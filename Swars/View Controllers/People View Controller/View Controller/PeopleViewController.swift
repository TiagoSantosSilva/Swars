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
    
    // MARK: - Dispose Bag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View Model
    
    private var viewModel: PeopleViewModelRepresentable!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PeopleViewModel(dataDependencies: DataDependencies())
        
        viewModel.dataSource.catchError { error in
            print(error)
            return Observable.empty()
            }
            .bind(to: collectionView.rx.items(cellIdentifier: PersonCell.identifier, cellType: PersonCell.self)) { (_, model, cell) in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
        
        // TODO: - Model Selection Action Bind
    }
    
    // MARK: - Setups
    
    override func setupViewController() {
        super.setupViewController()
        title = "Star Wars People"
    }
}
