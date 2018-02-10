//
//  UIViewControllerExtension.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension UIViewController {
    
    internal func dismissWithFadeTransition() {
        let transition = FadeTransition()
        view.window!.layer.add(transition, forKey: nil)
        dismiss(animated: false, completion: nil)
    }
    
}
