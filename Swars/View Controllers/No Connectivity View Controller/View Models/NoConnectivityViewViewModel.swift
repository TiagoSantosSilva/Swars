//
//  NoConnectivityViewViewModel.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import Reachability

class NoConnectivityViewViewModel {
    
    // MARK: - Reachability Property
    
    private var reachability: Reachability!
    
    // MARK: - Delegates
    
    private var delegate: NoConnectivityDelegate?
    
    // MARK: - Init & Deinit
    
    init(reachability: Reachability, noConnectivityDelegate: NoConnectivityDelegate) {
        self.reachability = reachability
        self.delegate = noConnectivityDelegate
        
        addObserver()
    }
    
    // MARK: - Selectors
    
    @objc func reachabilityChanged(note: Notification) {
        guard let reachability = note.object as? Reachability else { return }
        
        switch reachability.connection {
        case .wifi, .cellular:
            removeObserver()
            delegate?.connectivityWasObtained()
        default:
            return
        }
    }
}

// MARK: - Reachability Protocol Implementation

extension NoConnectivityViewViewModel: ReachabilityProtocol {
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
