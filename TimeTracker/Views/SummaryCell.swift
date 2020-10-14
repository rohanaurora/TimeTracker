//
//  SummaryCell.swift
//  TimeTracker
//
//  Created by Rohan Aurora on 10/13/20.
//  Copyright © 2020 Rohan Aurora. All rights reserved.
//

import UIKit 

class SummaryCell: UITableViewCell {
    
    static let cellID:String = "SummaryCell"
    static let nibName:String = "SummaryCell"
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var datasource: Entry? {
        didSet { self.updateView() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateView() {
        if let datasource = datasource, let start = datasource.sDate, let end = datasource.eDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d"
            startLabel.text = formatter.string(from: start)
            endLabel.text = formatter.string(from: end)
            hoursLabel.text = datasource.calculateHours()
        }
    }
    
    
}
