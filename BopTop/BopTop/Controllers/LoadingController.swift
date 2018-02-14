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
        
        let mainTabBarController = MainTabBarController()
        navigationController?.pushViewController(mainTabBarController, animated: true)
    }
    
    func setupViews() {
        setupBackgroundView()
        setupLoadingIconView()
        
    }
    
    fileprivate func setupBackgroundView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .red
        view.addSubview(backgroundView)
        backgroundView.fillSuperview()
    }
    
    fileprivate func setupLoadingIconView() {

    }
}
