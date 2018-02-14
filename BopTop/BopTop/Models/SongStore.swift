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

class SongStore {
    func fetchTopBops(completion: @escaping (TopBopsResult) -> Void) {
  
        let url1 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "A Millie Freemix", ofType: "mp3")!)
        let url2 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Piggy Bank", ofType: "mp3")!)
        
        let song1 = Song.init(url: url2, artist: "50 Cent", title: "Playa", plays: 27, likes: 15, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "50cent"))
        let song2 = Song.init(url: url1, artist: "Weezy", title: "A Millie", plays: 48, likes: 37, date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)), image: #imageLiteral(resourceName: "lilwayne"))
        let week1 = Week.init(songs: [song1,song2,song1,song2,song1,song2,song1], date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)))
        let week2 = Week.init(songs: [song1,song2,song1,song2,song1,song2,song1], date: Date.init(timeIntervalSinceNow: TimeInterval.init(0)))
        
        let topBops = TopBops.init(weeks: [week1, week2])
        
        let result = TopBopsResult.success(topBops)
        completion(result)
    }
}
