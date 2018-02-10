//
//  PeopleCollectionViewCell.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {

    // MARK: - IB Outlets
    
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personSpeciesLabel: UILabel!
    @IBOutlet weak var vehicleNumberLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuration
    
    func configure(with viewModel: PersonCellViewModelRepresentable) {
        personNameLabel.text = viewModel.name
        personSpeciesLabel.text = viewModel.species
        vehicleNumberLabel.text = viewModel.vehicleCount
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        personNameLabel.text = ""
        personSpeciesLabel.text = ""
        vehicleNumberLabel.text = ""
        super.prepareForReuse()
    }
}
