//
//  Entry.swift
//  TimeTracker
//
//  Created by Rohan Aurora on 10/13/20.
//  Copyright © 2020 Rohan Aurora. All rights reserved.
//

import Foundation

struct Entry {
    
    var sDate: Date?
    var eDate: Date?
    
    init(start: Date, end: Date) {
        sDate = start
        eDate = end
    }

    public func calculateHours() -> String {
        let cal = Calendar.current
        if let d1 = sDate, let d2 = eDate {
            let components = cal.dateComponents([.hour], from: d1, to: d2)
            let diff = abs(components.hour ?? 0)
            return String(diff) + " hours"
        }
        return ""
    }
}


