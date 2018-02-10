//
//  FadeTransition.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class FadeTransition: CATransition {
    override init() {
        super.init()
        self.duration = 0.3
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.type = kCATransitionFade
        self.subtype = kCATransitionFromBottom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
