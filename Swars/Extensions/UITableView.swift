//
//  UITableViewExtension.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could Not Dequeue Cell With Id: \(T.identifier)")
        }
        
        return cell
    }
}
