//
//  WannabeBopsViewController.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/13/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit

class WannabeBopsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        navigationItem.title = "Wannabe Bops"
        navigationController?.navigationBar.barStyle = UIBarStyle.default
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5.0
        layout.headerReferenceSize = CGSize.init(width: view.frame.width, height: 120)
        layout.scrollDirection = .vertical
        let wannabeBopsCollectionController = WannabeBopsCollectionController.init(collectionViewLayout: layout)
        addChildViewController(wannabeBopsCollectionController)
        view.addSubview(wannabeBopsCollectionController.view)
        wannabeBopsCollectionController.view.fillSuperview()
        
        wannabeBopsCollectionController.collectionView?.contentInset = .init(top: 0, left: 0, bottom: 60, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(playerController.view)
        if tabBarController != nil {
            playerController.view.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 60))
            
        }
    }

}
