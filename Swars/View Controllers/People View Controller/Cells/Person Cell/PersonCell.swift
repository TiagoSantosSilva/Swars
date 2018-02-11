//
//  PeopleCollectionViewCell.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PersonCell: UICollectionViewCell {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personSpeciesLabel: UILabel!
    @IBOutlet weak var vehicleNumberLabel: UILabel!
    
    // MARK: - Dispose Bag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuration
    
    func configure(with viewModel: PersonCellViewModelRepresentable) {
        personNameLabel.text = viewModel.name
        vehicleNumberLabel.text = viewModel.vehicleCount
        
        viewModel.speciesDataSource.catchError { error in
            print(error)
            return Observable.empty()
            }.bind(to: personSpeciesLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        personNameLabel.text = ""
        personSpeciesLabel.text = ""
        vehicleNumberLabel.text = ""
        super.prepareForReuse()
    }
}
