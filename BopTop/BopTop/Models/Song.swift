//
//  TopBop.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/13/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import Foundation
import AVKit

class Song : Equatable {
    static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    var url : URL
    var artist : String
    var title : String
    var plays : Int
    var likes : Int
    var date : Date
    var image : UIImage?
    var uid : String
    
    init(url: URL, artist: String, title: String, plays: Int, likes: Int, date: Date, image: UIImage?, uid: String) {
        self.url = url
        self.artist = artist
        self.title = title
        self.plays = plays
        self.likes = likes
        self.date = date
        self.image = image
        self.uid = uid
    }
    
}
