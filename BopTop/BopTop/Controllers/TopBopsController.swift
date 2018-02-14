//
//  TopBopsController.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/13/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit
import AVFoundation

class TopBopsController: UIViewController {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Top Bops"
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5.0
        layout.headerReferenceSize = CGSize.init(width: view.frame.width, height: 20)
        layout.scrollDirection = .vertical
        
        let topBopsCollectionController = TopBopsCollectionController.init(collectionViewLayout: layout)
        addChildViewController(topBopsCollectionController)
        view.addSubview(topBopsCollectionController.view)
        topBopsCollectionController.view.fillSuperview()
        
    }
    
    

}
