//
//  PlayerViewController.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/15/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

enum PlayerState {
    case isNil
    case isPaused
    case isPlaying
}

class PlayerViewController: UIViewController {

    var currentSong : (song: Song, indexPath: IndexPath, sender: String)?
    var state: PlayerState = .isNil {
        didSet {
            enableButtons()
            if(state == .isPlaying) {
                NotificationCenter.default.post(name: Notification.Name("isPlaying"), object: nil, userInfo: ["indexPath": currentSong?.indexPath ?? "", "sender": currentSong?.sender ?? ""])
            } else if (state == .isPaused) {
                NotificationCenter.default.post(name: Notification.Name("isPaused"), object: nil, userInfo: ["indexPath": currentSong?.indexPath ?? "", "sender": currentSong?.sender ?? ""])
            }
        }
    }
    var queue : [(song: Song, indexPath: IndexPath, sender: String)] = []
    var songIndex : Int = 0
    
    var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "music_placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.text = "Not Playing"
        return label
    }()
    
    var artistLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "Select a Song"
        return label
    }()
    
    var playButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
        button.imageView?.tintColor = .white
        button.isEnabled = false
        button.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        return button
    }()
    var skipButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "next"), for: UIControlState.normal)
        button.imageView?.tintColor = .white
        button.isEnabled = false
        button.addTarget(self, action: #selector(skipPressed), for: .touchUpInside)
        return button
    }()
    var previousButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "prev"), for: UIControlState.normal)
        button.imageView?.tintColor = .white
        button.isEnabled = false
        button.addTarget(self, action: #selector(previousPressed), for: .touchUpInside)
        return button
    }()
    
    let commandCenter = MPRemoteCommandCenter.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableButtons()
        commandCenter.pauseCommand.addTarget { [unowned self] (event) -> MPRemoteCommandHandlerStatus in
            self.pause()
            return MPRemoteCommandHandlerStatus.success
        }
        commandCenter.playCommand.addTarget { [unowned self] (event) -> MPRemoteCommandHandlerStatus in
            self.playPressed()
            return MPRemoteCommandHandlerStatus.success
        }
        commandCenter.nextTrackCommand.addTarget { [unowned self] (event) -> MPRemoteCommandHandlerStatus in
            self.skipPressed()
            return MPRemoteCommandHandlerStatus.success
        }
        commandCenter.previousTrackCommand.addTarget { [unowned self] (event) -> MPRemoteCommandHandlerStatus in
            self.previousPressed()
            return MPRemoteCommandHandlerStatus.success
        }
        
//        view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            view.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            view.backgroundColor = .black
        }
        
        view.topBorder(color: UIColor.black, thickness: 0.5)
        
        [previousButton, playButton, skipButton, titleLabel, artistLabel, imageView].forEach { [unowned self] (view) in
            self.view.addSubview(view)
        }
        
        skipButton.anchor(nil, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 30, heightConstant: 30)
        skipButton.anchorCenterYToSuperview()
        
        playButton.anchor(nil, left: nil, bottom: nil, right: skipButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 40, heightConstant: 40)
        playButton.centerYAnchor.constraint(equalTo: skipButton.centerYAnchor).isActive = true
        
        previousButton.anchor(nil, left: nil, bottom: nil, right: playButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 30, heightConstant: 30)
        previousButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        
        imageView.anchor(nil, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        imageView.anchorCenterYToSuperview()
        
        titleLabel.anchor(view.topAnchor, left: imageView.rightAnchor, bottom: nil, right: previousButton.leftAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        artistLabel.anchor(nil, left: titleLabel.leftAnchor, bottom: view.bottomAnchor, right: titleLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setSong(song: Song, indexPath: IndexPath, sender: String) {
        if let image = song.image {
            self.imageView.image = image
        } else {
           self.imageView.image = #imageLiteral(resourceName: "music_placeholder")
        }
        
        self.titleLabel.text = song.title
        self.artistLabel.text = song.artist
        self.currentSong = (song: song, indexPath: indexPath, sender: sender)
        let item = AVPlayerItem.init(url: song.url)
        Player.sharedInstance.replaceCurrentItem(with: item)
        NotificationCenter.default.post(name: Notification.Name("didChangeSongs"), object: nil, userInfo: ["indexPath": currentSong?.indexPath ?? "", "sender": currentSong?.sender ?? ""])
    }
    
    func pause() {
        playButton.imageView?.image = #imageLiteral(resourceName: "play")
        Player.sharedInstance.pause()
        state = PlayerState.isPaused
    }
    
    @objc func playPressed() {
        if(state == .isPlaying){
            //pause
            Player.sharedInstance.pause()
            state = .isPaused
        } else if (state == .isPaused) {
            //play
            guard currentSong != nil else{
                return
            }
            Player.sharedInstance.play()
            state = .isPlaying
        }
    }
    
    func play(song: Song, indexPath: IndexPath, sender: String) {
        if (state == .isNil || song.uid != currentSong?.song.uid) {
            //reset queue because it is the first song or it is a new song
            Player.sharedInstance.pause()
            queue.removeAll()
            addToQueue(song: song, indexPath: indexPath, sender: sender)
            state = .isPaused
        }
        //set song, add it to queue, play it
        setSong(song: song, indexPath: indexPath, sender: sender)
        Player.sharedInstance.play()
        state = .isPlaying
    }
    
    func addToQueue(song: Song, indexPath: IndexPath, sender: String) {
        queue.append((song: song, indexPath: indexPath, sender: sender))
        if(queue.count == 1) {
            setSong(song: song, indexPath: indexPath, sender: sender)
        }
    }
    
    @objc func skipPressed() {
        
        if(songIndex + 1 >= queue.endIndex) {
            //end of queue, reset queue
            pause()
            if let song = currentSong {
                goToStartOfCurrentSong()
            }
            state = .isPaused
        } else {
            //next song
            songIndex = songIndex + 1
            let song = queue[songIndex]
            setSong(song: song.song, indexPath: song.indexPath, sender: song.sender)
        }
    }
    
    func goToStartOfCurrentSong() {
        Player.sharedInstance.seek(to: kCMTimeZero)
    }
    
    @objc func previousPressed() {
        if(songIndex > 0){
            songIndex = songIndex - 1
        }
        let song = queue[songIndex]
        setSong(song: song.song, indexPath: song.indexPath, sender: song.sender)
    }
    
    func setSongAsNil() {
        DispatchQueue.main.async { [unowned self] in
            self.imageView.image = #imageLiteral(resourceName: "music_placeholder")
            self.titleLabel.text = "Not Playing"
            self.artistLabel.text = "Select a Song"
        }
    }
    
    fileprivate func enableButtons() {
        DispatchQueue.main.async { [unowned self] in
            if(self.state == PlayerState.isPlaying){
                self.playButton.imageView?.image = #imageLiteral(resourceName: "pause")
                self.playButton.isEnabled = true
                self.commandCenter.playCommand.isEnabled = false
                self.commandCenter.pauseCommand.isEnabled = true
            } else if(self.state == PlayerState.isPaused) {
                self.playButton.imageView?.image = #imageLiteral(resourceName: "play")
                self.playButton.isEnabled = true
                self.commandCenter.playCommand.isEnabled = true
                self.commandCenter.pauseCommand.isEnabled = false
            } else {
                self.playButton.imageView?.image = #imageLiteral(resourceName: "play")
                self.playButton.isEnabled = false
                self.commandCenter.playCommand.isEnabled = false
                self.commandCenter.pauseCommand.isEnabled = false
            }
            if(self.state == PlayerState.isNil) {
                self.skipButton.isEnabled = false
                self.commandCenter.skipForwardCommand.isEnabled = false
                self.previousButton.isEnabled = false
                self.commandCenter.previousTrackCommand.isEnabled = false
            } else {
                self.skipButton.isEnabled = true
                self.commandCenter.skipForwardCommand.isEnabled = true
                self.previousButton.isEnabled = true
                self.commandCenter.previousTrackCommand.isEnabled = true
            }
        }
    }
    
    @objc func songDidFinishPlaying() {
        //song played fully through
    }
}
