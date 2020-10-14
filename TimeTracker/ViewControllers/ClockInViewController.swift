//
//  ClockInViewController.swift
//  TimeTracker
//
//  Created by Rohan Aurora on 10/12/20.
//  Copyright © 2020 Rohan Aurora. All rights reserved.
//

import UIKit

class ClockInViewController: UIViewController {

    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var viewModel: ClockInViewModel?
    weak var delegate: MainViewController!
    var entry:Entry!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hoursLabel.text = "0 hours"
        viewModel = ClockInViewModel()
        startDate.text = viewModel?.displayDate(datePicker.date) ?? ""
    }
    
    @IBAction func datePickerTapped(_ sender: Any) {
        hoursLabel.numberOfLines = 0
        hoursLabel.text = viewModel?.calculateHours(d2: datePicker.date)
    }
    

    @IBAction func dismissVC(_ sender: Any) {
        delegate.viewModel = viewModel
        entry = Entry.init(start: Date(), end: datePicker.date)
        Summary.shared.append(entry)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func timezoneChanged(_ sender: Any) {
        // TODO
    }
}
