//
//  Player.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/14/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit
import AVFoundation

class Player: AVPlayer {
    static let sharedInstance = Player()
    
    var player: AVPlayer = AVPlayer()
    let session = AVAudioSession.sharedInstance()
    
    override init() {
        super.init()
        
    }
    
    override func play() {
        super.play()
        // Put play code here
        do {
            try session.setActive(true)
        } catch let error {
            print("Unable to activate audio session: \(error.localizedDescription)")
        }
    }
    
}
