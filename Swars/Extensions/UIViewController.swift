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
    
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 13/255, green: 13/255, blue: 13/275, alpha: 0.4)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        spinnerView.addSubview(ai)
        onView.addSubview(spinnerView)
        
        return spinnerView
    }
    
    class func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.7, animations: {
                spinner.alpha = 0
            }, completion: {_ in
                spinner.removeFromSuperview()
            })
        }
    }
}
