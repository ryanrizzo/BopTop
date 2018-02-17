//
//  WannabeBopsHeader.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/16/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit

class WannabeBopsHeader: UICollectionViewCell {
    let todayLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = NSTextAlignment.center
        label.text = "Songs Uploaded Today"
        return label
    }()
    
    let infoLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 10
        label.text = "Only one of these songs will be the Top Bop of the day.\nEvery other song is deleted at the end of the day.\nThe winner is judged by likes + plays."
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        clipsToBounds = true
        addSubview(todayLabel)
        todayLabel.anchor(topAnchor, left: nil, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        todayLabel.anchorCenterXToSuperview()
        
        addSubview(infoLabel)
        infoLabel.anchor(todayLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 7, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
