//
//  BaseViewController.swift
//  Swars
//
//  Created by Tiago Santos on 09/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

class BaseViewController: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Reachability Properties
    
    private lazy var reachability = Reachability()!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
    
    // MARK: - Setups
    
    func setupViewController() {
        setupView()
        setupNavigationController()
        startReachabilityNotifier()
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
    
    func startReachabilityNotifier() {
        startNotifier()
    }
    
    // MARK: - Reachability Selectors
    
    @objc private func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .none:
            print("Network not reachable")
            let noConnectivityViewController = NoConnectivityViewController(reachability: reachability)
            present(noConnectivityViewController, animated: true, completion: nil)
        default:
            return
        }
    }
}

// MARK: - Reachability Protocol Implementation

extension BaseViewController: ReachabilityProtocol {
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    func startNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }
}
