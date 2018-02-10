//
//  ReachabilityProtocol.swift
//  Swars
//
//  Created by Tiago Santos on 09/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

protocol ReachabilityProtocol {
    func addObserver()
    func removeObserver()
    func startNotifier()
}
