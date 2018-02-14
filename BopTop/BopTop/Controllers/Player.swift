//
//  Player.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/14/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import UIKit
import AVFoundation

class Player: AVQueuePlayer {
    static let sharedInstance = Player()
    
    var player: AVQueuePlayer = AVQueuePlayer()
    
    override func play() {
        super.play()
        // Put play code here
    }
    
    func playWithURL(url : NSURL) {
        // Put play code here
    }
    
}
