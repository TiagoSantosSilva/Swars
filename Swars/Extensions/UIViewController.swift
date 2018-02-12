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
    
    class func displayActivityIndicatorView(onView: UIView) -> UIView {
        let activityIndicatorView = UIView.init(frame: onView.bounds)
        activityIndicatorView.backgroundColor = UIColor.init(red: 13/255, green: 13/255, blue: 13/275, alpha: 0.4)
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = activityIndicatorView.center
        activityIndicatorView.addSubview(activityIndicator)
        onView.addSubview(activityIndicatorView)
        
        return activityIndicatorView
    }
    
    class func removeActivityIndicatorView(activityIndicatorView: UIView) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.7, animations: {
                activityIndicatorView.alpha = 0
            }, completion: {_ in
                activityIndicatorView.removeFromSuperview()
            })
        }
    }
}
