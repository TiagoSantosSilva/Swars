//
//  Roundable.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

protocol Roundable { }

extension Roundable where Self: UIView {
    
    func rounded(with radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
}
