//
//  NoConnectivityViewController.swift
//  Swars
//
//  Created by Tiago Santos on 09/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

protocol NoConnectivityDelegate {
    func connectivityWasObtained()
}

class NoConnectivityViewController: UIViewController {
    
    // MARK: - View Model
    
    private var noConnectivityViewModel: NoConnectivityViewViewModel!

    // MARK: - Bar Status Style
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Convenience initializers
    
    convenience init(reachability: Reachability) {
        self.init()
        noConnectivityViewModel = NoConnectivityViewViewModel(reachability: reachability, noConnectivityDelegate: self)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension NoConnectivityViewController: NoConnectivityDelegate {
    func connectivityWasObtained() {
        self.dismiss(animated: true, completion: nil)
    }
}

