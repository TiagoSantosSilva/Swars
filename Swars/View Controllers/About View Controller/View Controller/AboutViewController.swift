//
//  AboutViewController.swift
//  Swars
//
//  Created by Tiago Santos on 09/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    // MARK: - IB Outlets
    
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var informationTableView: UITableView!
    
    // MARK: - Properties
    
    private let viewControllerTitle = "About"
    
    // MARK: - View Model
    
    private var aboutViewModel: AboutViewModel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setups
    
    override func setupViewController() {
        super.setupViewController()
        title = viewControllerTitle
    }
}
