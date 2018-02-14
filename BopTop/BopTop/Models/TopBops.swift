//
//  TopBops.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/13/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import Foundation

class TopBops {
    var weeks : [Week]
    
    init(weeks: [Week]) {
        self.weeks = weeks
    }
}

class Week {
    var songs : [Song]
    var date : String
    
    init(songs: [Song], date: Date) {
        self.songs = songs
        self.date = DateHelper.dateToMonthDay(date: date)
    }
}
