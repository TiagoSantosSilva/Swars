//
//  BaseViewModel.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import Reachability

class BaseViewModel {
    
    // MARK: - Reachability Properties
    
    private lazy var reachability = Reachability()!
    
    // MARK: - Delegates
    
    private var delegate: BaseViewControllerDelegate?
    
    // MARK: - Init
    
    init(reachability: Reachability, baseViewControllerDelegate: BaseViewControllerDelegate) {
        self.reachability = reachability
        self.delegate = baseViewControllerDelegate
        
        startNotifier()
    }
    
    // MARK: - View Life Cycle
    
    func viewAppeared() {
        addObserver()
    }
    
    func viewDisappeared() {
        removeObserver()
    }
    
    // MARK: - Selectors
    
    @objc func reachabilityChanged(note: Notification) {
        guard let reachability = note.object as? Reachability else { return }
        
        switch reachability.connection {
        case .none:
            print("Network not reachable")
            delegate?.connectivityWasLost()
        default:
            return
        }
    }
}

// MARK: - Reachability Protocol Implementation

extension BaseViewModel: ReachabilityProtocol {
    
    internal func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
    }
    
    internal func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    internal func startNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }
}
