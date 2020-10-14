//
//  ClockInViewModel.swift
//  TimeTracker
//
//  Created by Rohan Aurora on 10/12/20.
//  Copyright © 2020 Rohan Aurora. All rights reserved.
//

import UIKit

struct ClockInViewModel {
    var hours: Int?
    var minutes: Int?

    public mutating func calculateHours(d2: Date) -> String {
        let cal = Calendar.current
        let d1 = Date()
        let d2 = d2
        let components = cal.dateComponents([.hour], from: d1, to: d2)
        let diffh = abs(components.hour ?? 0)
        let diffm = abs(components.minute ?? 0)
        hours = diffh
        minutes = diffm
        return String(diffh) + "h" + String(diffm) + "m"
    }
    
    public func displayDate(_ input:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "h:mm a"
        return "Start Date " + dateFormatter.string(from: input)
    }
}
