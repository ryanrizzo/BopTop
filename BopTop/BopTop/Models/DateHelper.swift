//
//  DateFormatter.swift
//  BopTop
//
//  Created by Ryan Rizzo on 2/13/18.
//  Copyright © 2018 Ryan Rizzo. All rights reserved.
//

import Foundation

struct DateHelper {
    public static func dateToWeekday(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "EEEE"
        let myStringafd = formatter.string(from: yourDate!)
        let abbrev = myStringafd.prefix(3)
        return String(abbrev)
    }
    
    public static func dateToMonthDay(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "MM/dd"
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }
}
