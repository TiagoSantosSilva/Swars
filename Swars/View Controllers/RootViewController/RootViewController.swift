//
//  RootViewController.swift
//  Swars
//
//  Created by Tiago Santos on 09/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setups
    
    func setupView() {
        setupViewControllers()
        setupTabBar()
    }
    
    func setupViewControllers() {
        let peopleViewController = PeopleViewController()
        peopleViewController.tabBarItem = UITabBarItem(title: "Star Wars People", image: UIImage(named: "star_wars_people"), tag: 0)
        
        let aboutViewController = AboutViewController()
        aboutViewController.tabBarItem = UITabBarItem(title: "About", image: UIImage(named: "about"), tag: 1)
        
        let viewControllerList = [peopleViewController, aboutViewController]
        
        viewControllers = viewControllerList.map {
            UINavigationController(rootViewController: $0)
        }
    }
    
    func setupTabBar() {
        tabBar.barTintColor = UIColor.darkGrayColor
    }
}
