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

        let wannabeBopsCollectionController = TopBopsCollectionController()
        addChildViewController(wannabeBopsCollectionController)
        view.addSubview(wannabeBopsCollectionController.view)
        wannabeBopsCollectionController.view.fillSuperview()
    }

}
