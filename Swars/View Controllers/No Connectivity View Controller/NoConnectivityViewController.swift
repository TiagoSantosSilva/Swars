//
//  NoConnectivityViewController.swift
//  Swars
//
//  Created by Tiago Santos on 09/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

class NoConnectivityViewController: UIViewController {
    
    // MARK: - Reachability Property
    
    private var reachability: Reachability!

    // MARK: - Bar Status Style
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Convenience initializers
    
    convenience init(reachability: Reachability) {
        self.init()
        self.reachability = reachability
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeObserver()
    }
    
    // MARK: - Reachability Changed Selector
    // TODO: - Make the View Model handle this instead. Notify via Delegate.
    
    @objc func reachabilityChanged(note: Notification) {
        guard let reachability = note.object as? Reachability else { return }
        
        switch reachability.connection {
        case .wifi, .cellular:
            self.dismiss(animated: true, completion: nil)
        default:
            return
        }
    }
}

// MARK: - Reachability Protocl Implementation

extension NoConnectivityViewController: ReachabilityProtocol {
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    func startNotifier() {
        return
    }
}
