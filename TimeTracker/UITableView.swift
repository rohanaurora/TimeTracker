//
//  UITableView.swift
//  TimeTracker
//
//  Created by Rohan Aurora on 10/13/20.
//  Copyright © 2020 Rohan Aurora. All rights reserved.
//

import UIKit

extension UITableView {
    
    // Export pdf from UITableView and save pdf in drectory and return pdf file path
    func exportAsPdfFromTable() -> String {
        
        let originalBounds = self.bounds
        self.bounds = CGRect(x:originalBounds.origin.x, y: originalBounds.origin.y, width: self.contentSize.width, height: self.contentSize.height)
        let pdfPageFrame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.contentSize.height)
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
        self.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        self.bounds = originalBounds
        // Save pdf data
        return self.saveTablePdf(data: pdfData)
        
    }
    
    // Save pdf file in document directory
    func saveTablePdf(data: NSMutableData) -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("summary.pdf")
        if data.write(to: pdfPath, atomically: true) {
            return pdfPath.path
        } else {
            return ""
        }
    }
}
