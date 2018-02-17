//
//  WannabeBopCell.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/16/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit

class WannabeBopCell: UICollectionViewCell {
    var playTapped : (()->())?
    
    let speakerView = SpeakerView.init(frame: .init(x: 0, y: 0, width: 30, height: 30*1.74))
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    let likesIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "heart")
        imageView.tintColor = .white
        return imageView
    }()
    
    let playsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "play")
        imageView.tintColor = .white
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.shadowColor = .black
        label.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        label.shadowColor = .black
        label.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        return label
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.shadowColor = .black
        label.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        return label
    }()
    
    let playsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.shadowColor = .black
        label.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.shadowColor = .black
        label.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(dateLabel)
        dateLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addSubview(artistLabel)
        artistLabel.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addSubview(titleLabel)
        titleLabel.anchor(nil, left: artistLabel.leftAnchor, bottom: artistLabel.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 3, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addSubview(playsLabel)
        playsLabel.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 10)
        
        addSubview(likesLabel)
        likesLabel.anchor(playsLabel.bottomAnchor, left: nil, bottom: nil, right: playsLabel.rightAnchor, topConstant: 3, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        addSubview(likesIcon)
        likesIcon.anchor(likesLabel.topAnchor, left: nil, bottom: likesLabel.bottomAnchor, right: likesLabel.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 4, widthConstant: 10, heightConstant: 10)
        
        addSubview(playsIcon)
        playsIcon.anchor(playsLabel.topAnchor, left: nil, bottom: playsLabel.bottomAnchor, right: likesIcon.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 10, heightConstant: 10)
        
        addSubview(speakerView)

        speakerView.anchorCenterSuperview()
    }
    
    func setupViews() {
        clipsToBounds = true
        layer.cornerRadius = 7.0
        backgroundColor = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
