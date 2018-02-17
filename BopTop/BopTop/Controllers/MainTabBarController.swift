//
//  MainTabBarController.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/13/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit

let playerController = PlayerViewController()

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barStyle = UIBarStyle.black
        tabBar.tintColor = .yellow
        tabBar.unselectedItemTintColor = .white
        tabBar.isTranslucent = false
        
        
    }
}
