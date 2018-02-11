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
            informationTableView.tableFooterView = UIView()
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
        informationTableView.delegate = self
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? UITableViewHeaderFooterView else {
            return
        }
        
        view.backgroundView?.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0.01960784314, blue: 0.01960784314, alpha: 1)
        view.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.textLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20)
    }
}
