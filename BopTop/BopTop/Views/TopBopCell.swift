//
//  TopBopCell.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/13/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit

class TopBopCell: UICollectionViewCell {
    
    var playTapped : (()->())?
    var isPlaying = false
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
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
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
        button.imageView?.tintColor = .white
        button.imageView?.layer.shadowColor = UIColor.black.cgColor
        button.imageView?.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        addSubview(imageView)
        imageView.fillSuperview()

        addSubview(dateLabel)
        dateLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 5, bottom: 0, right: 0), size: .zero)
        
        addSubview(artistLabel)
        artistLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 5, bottom: 5, right: 0), size: .zero)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: nil, leading: artistLabel.leadingAnchor, bottom: artistLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 3, right: 0), size: .zero)
        
        addSubview(playsLabel)
        playsLabel.anchor(top: self.topAnchor, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 5), size: .zero)
        
        addSubview(likesLabel)
        likesLabel.anchor(top: playsLabel.bottomAnchor, leading: nil, bottom: nil, trailing: playsLabel.trailingAnchor, padding: .init(top: 3, left: 0, bottom: 0, right: 0), size: .zero)
        
        addSubview(playButton)
        playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        playButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .zero, size: .init(width: 40, height: 40))
        playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
    }
    
    @objc func playPressed() {
        playTapped?()
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
