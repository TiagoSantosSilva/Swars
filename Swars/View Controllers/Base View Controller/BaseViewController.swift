//
//  BaseViewController.swift
//  Swars
//
//  Created by Tiago Santos on 09/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

protocol BaseViewControllerDelegate {
    func connectivityWasLost()
}

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Reachability Property
    
    private let reachability = Reachability()!
    
    // MARK: - View Model
    
    private var baseViewModel: BaseViewModel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseViewModel.viewAppeared()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        baseViewModel.viewDisappeared()
    }
    
    // MARK: - Setups
    
    func setupViewController() {
        setupViewModel()
        setupView()
        setupNavigationController()
    }
    
    func setupViewModel() {
        baseViewModel = BaseViewModel(reachability: reachability, baseViewControllerDelegate: self)
    }
    
    func setupView() {
        view.backgroundColor = UIColor.blackColor
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
    }
}

extension BaseViewController: BaseViewControllerDelegate {
    func connectivityWasLost() {
        let noConnectivityViewController = NoConnectivityViewController(reachability: reachability)
        present(noConnectivityViewController, animated: true, completion: nil)
    }
}
