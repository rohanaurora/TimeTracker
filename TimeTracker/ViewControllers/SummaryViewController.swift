//
//  SummaryViewController.swift
//  TimeTracker
//
//  Created by Rohan Aurora on 10/12/20.
//  Copyright © 2020 Rohan Aurora. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    var datasource: [Entry]!
    var dc: UIDocumentInteractionController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dc = UIDocumentInteractionController.init()
        dc?.delegate = self

        prepareViews()
    }
    
    private func prepareViews() {
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItems = [share]
        
        prepareTableView()
        datasource = Summary.shared.items
    }
    
    private func prepareTableView() {
        let nibCell = UINib(nibName: SummaryCell.nibName, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: SummaryCell.cellID)
    }
}

// MARK: - Table view datasource and delegate
extension SummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryCell else {
            fatalError("Failed to dequeue a SummaryCell.")
        }
        
        cell.datasource = datasource[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            Summary.shared.remove(at: indexPath.row)
            datasource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    @objc func shareTapped(_ sender: UIBarButtonItem) {
        let file = tableView.exportAsPdfFromTable()
        showSavedPdf(url: file, fileName: "summary.pdf")
        print(file)
    }
}

extension SummaryViewController {
    public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }

    private func showSavedPdf(url:String, fileName:String) {
        do {
            let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
            for url in contents {
                if url.description.contains("summary.pdf") {
                    dc?.url = url
                    dc?.presentPreview(animated: true)
                }
            }
        } catch {
            print("No file")
        }
    }
}
