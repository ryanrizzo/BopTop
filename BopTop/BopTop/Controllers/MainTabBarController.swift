//
//  MainTabBarController.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/13/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit



class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let topBopsController = TopBopsController()
        let wannabeBopsController = WannabeBopsController()
        let topBopsNavController = UINavigationController(rootViewController: topBopsController)
        let wannabeBopsNavController = UINavigationController(rootViewController: wannabeBopsController)
        topBopsNavController.tabBarItem = UITabBarItem.init(title: "Top Bops", image: nil, tag: 0)
        wannabeBopsNavController.tabBarItem = UITabBarItem.init(title: "Wannabe Bops", image: nil, tag: 0)
        let viewControllerList = [topBopsNavController, wannabeBopsNavController]
        viewControllers = viewControllerList
    }
}
