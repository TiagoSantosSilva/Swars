//
//  AboutCell.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {

    // MARK: - Reuse Identifier
    
    static let reuseIdentifier = "AboutCell"
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var informationLabel: UILabel!
    
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setups
    
    func configure(with viewModel: AboutCellViewModel) {
        informationLabel.text = viewModel.informationText
    }

    // MARK: -
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
