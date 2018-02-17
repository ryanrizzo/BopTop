//
//  LoadingViewController.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/13/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit

class LoadingController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupChildrenControllers()
    }
    
    func setupViews() {
        setupBackgroundView()
        setupLoadingIconView()
        setupSpeaker()
        
    }
    
    fileprivate func setupChildrenControllers() {
        let mainTabBarController = MainTabBarController()
        
        let topBopsController = TopBopsController()
        let wannabeBopsController = WannabeBopsController()
        
        let topBopsNavController = UINavigationController(rootViewController: topBopsController)
        let wannabeBopsNavController = UINavigationController(rootViewController: wannabeBopsController)
        
        topBopsNavController.tabBarItem = UITabBarItem.init(title: "Top Bops", image: #imageLiteral(resourceName: "speakerIcon"), tag: 0)
        wannabeBopsNavController.tabBarItem = UITabBarItem.init(title: "Wannabe Bops", image: #imageLiteral(resourceName: "podium"), tag: 0)
        
        let viewControllerList = [topBopsNavController, wannabeBopsNavController]
        mainTabBarController.viewControllers = viewControllerList
        
        navigationController?.pushViewController(mainTabBarController, animated: true)
    }
    
    fileprivate func setupBackgroundView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        view.addSubview(backgroundView)
        backgroundView.fillSuperview()
    }
    
    fileprivate func setupSpeaker() {
        let speakerView = SpeakerView.init(frame: CGRect.init(x: 0, y: 0, width: 127, height: 127))
        view.addSubview(speakerView)
        speakerView.clipsToBounds = false
        speakerView.anchorCenterSuperview()
        speakerView.animatePulsatingLayer()
    }
    
    fileprivate func setupLoadingIconView() {

    }
}
