//
//  Summary.swift
//  TimeTracker
//
//  Created by Rohan Aurora on 10/13/20.
//  Copyright © 2020 Rohan Aurora. All rights reserved.
//

import Foundation

struct Summary {
    static var shared = Summary()
    var items:[Entry] = [] {
        didSet {
            
        }
    }

    private init() { }
    
    mutating func append(_ entry:Entry) {
        items.append(entry)
    }
    
    mutating func remove(at index: Int)  {
      items.remove(at: index)
    }
    
    mutating func removeAll() {
      items.removeAll()
    }
}
