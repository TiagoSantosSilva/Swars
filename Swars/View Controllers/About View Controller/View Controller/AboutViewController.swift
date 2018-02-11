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
    
    @IBOutlet weak var informationTableView: UITableView! {
        didSet {
            informationTableView.register(AboutCell.self)
        }
    }
    
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
        setupDelegates()
    }
    
    func setupDelegates() {
        informationTableView.dataSource = self
    }
    
    override func setupViewModel() {
        super.setupViewModel()
        aboutViewModel = AboutViewModel()
    }
}

extension AboutViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return aboutViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = informationTableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath) as? AboutCell else {
            fatalError("Could Not Dequeue Reusable Cell")
        }
        
        cell.informationLabel.text = aboutViewModel.rowContent(for: indexPath.section)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return aboutViewModel.sectionTitle(for: section)
    }
}
