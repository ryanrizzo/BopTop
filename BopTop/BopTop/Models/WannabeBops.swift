//
//  WannabeBops.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/16/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import Foundation

class WannabeBops {
    var songs : [Song]
    var date : String
    
    
    init(songs: [Song], date: Date) {
        self.songs = songs
        self.date = DateHelper.dateToMonthDay(date: date)
    }
}
