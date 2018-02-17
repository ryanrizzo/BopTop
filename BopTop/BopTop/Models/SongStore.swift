//
//  SongStore.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/13/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import Foundation

enum TopBopsResult {
    case success(TopBops)
    case failure(Error)
}

enum TopBopsError: Error {
    case songDownloadError
}

enum WannabeBopsResult {
    case success(WannabeBops)
    case failure(Error)
}

enum WannabeBopsError: Error {
    case songDownloadError
}

class SongStore {
    func fetchTopBops(completion: @escaping (TopBopsResult) -> Void) {
  
        let url1 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "A Millie Freemix", ofType: "mp3")!)
        let url2 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Piggy Bank", ofType: "mp3")!)
        
        let song1 = Song.init(url: url2, artist: "50 Cent", title: "Playa", plays: 27, likes: 15, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "50cent"), uid: "83dg4oq")
        let song2 = Song.init(url: url1, artist: "Weezy", title: "A Millie", plays: 48, likes: 37, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "lilwayne"), uid: "ch3qiu4f")
        let song3 = Song.init(url: url2, artist: "50 Cent", title: "Playa", plays: 27, likes: 15, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "50cent"), uid: "neo8e")
        let song4 = Song.init(url: url1, artist: "Weezy", title: "A Millie", plays: 48, likes: 37, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "lilwayne"), uid: "09fjas")
        let song5 = Song.init(url: url2, artist: "50 Cent", title: "Playa", plays: 27, likes: 15, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "50cent"), uid: "wbiuc")
        let song6 = Song.init(url: url1, artist: "Weezy", title: "A Millie", plays: 48, likes: 37, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "lilwayne"), uid: "bia7cc")
        let song7 = Song.init(url: url2, artist: "50 Cent", title: "Playa", plays: 27, likes: 15, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "50cent"), uid: "cuku4f4t5")
        let week1 = Week.init(songs: [song1,song2,song3,song4,song5,song6,song7], date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)))
        let week2 = Week.init(songs: [song1,song2,song3,song4,song5,song6,song7], date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)))
        
        let topBops = TopBops.init(weeks: [week1, week2])
        
        let result = TopBopsResult.success(topBops)
        completion(result)
    }
    
    func fetchWannabeBops(completion: @escaping (WannabeBopsResult) -> Void) {
        
        let url1 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "A Millie Freemix", ofType: "mp3")!)
        let url2 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Piggy Bank", ofType: "mp3")!)
        
        let song1 = Song.init(url: url2, artist: "50 Cent", title: "Playa", plays: 27, likes: 15, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "50cent"), uid: "cn48")
        let song2 = Song.init(url: url1, artist: "Weezy", title: "A Millie", plays: 48, likes: 37, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "lilwayne"), uid: "ocnir4")
        let song3 = Song.init(url: url2, artist: "50 Cent", title: "Playa", plays: 27, likes: 15, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "50cent"), uid: "8c4ino")
        let song4 = Song.init(url: url1, artist: "Weezy", title: "A Millie", plays: 48, likes: 37, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "lilwayne"), uid: "acnr")
        let song5 = Song.init(url: url2, artist: "50 Cent", title: "Playa", plays: 27, likes: 15, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "50cent"), uid: "c4iou")
        let song6 = Song.init(url: url1, artist: "Weezy", title: "A Millie", plays: 48, likes: 37, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "lilwayne"), uid: "3bcr4")
        let song7 = Song.init(url: url2, artist: "50 Cent", title: "Playa", plays: 27, likes: 15, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "50cent"), uid: "sjbcfh")
        let wannabeBops = WannabeBops.init(songs: [song1,song2,song3,song4,song5,song6,song7], date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)))
        
        let result = WannabeBopsResult.success(wannabeBops)
        completion(result)
    }
    
    func likeSong(song: Song) {
        
    }
}
