//
//  MainViewController.swift
//  TimeTracker
//
//  Created by Rohan Aurora on 10/12/20.
//  Copyright © 2020 Rohan Aurora. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainDisplay: UILabel!
    @IBOutlet weak var currentPeriod: UILabel!
    @IBOutlet weak var clockButton: UIButton!
    
    var viewModel: ClockInViewModel?
    var isChecked: Bool = false
    weak var timer: Timer?
    var starting: Date?
    
    private var formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPeriod.text = Constants.currentPeriod + Constants.defaultHours
        let add = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let hrs = viewModel?.hours ?? 0
        let min = viewModel?.minutes ?? 0

        currentPeriod.text = Constants.currentPeriod + String(hrs) + "h" + String(min) + "m"
        
    }
    
    @IBAction func clockInTime(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cvc = storyboard.instantiateViewController(withIdentifier: "cvc") as! ClockInViewController
        cvc.delegate = self
        navigationController?.pushViewController(cvc, animated: true)
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Summary", bundle: nil)
        let svc = storyboard.instantiateViewController(withIdentifier: "svc") as! SummaryViewController
        navigationController?.pushViewController(svc, animated: true)
    }
    
    
    @IBAction func startClockIn(_ sender: Any) {
        isChecked = !isChecked
        if isChecked {

            timer?.invalidate()
            clockButton.setTitle("Clock Out", for: .normal)
            clockButton.setTitleColor(.red, for: .normal)
            let entry = Entry(start: starting ?? Date(), end: Date())
            Summary.shared.append(entry)
        } else {
            startTimer()
            clockButton.setTitle("Clock In", for: .normal)
            clockButton.setTitleColor(.systemBlue, for: .normal)
        }
        
    }
    
    private func startTimer() {
        timer?.invalidate()
        let startTime = Date()
        starting = startTime
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                self?.mainDisplay.text = self?.formatter.string(from: startTime, to: Date())
        }
    }
}
