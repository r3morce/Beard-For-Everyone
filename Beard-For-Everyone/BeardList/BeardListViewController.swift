//
//  BeardListViewController.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 26.08.16.
//  Copyright © 2016 mathias. All rights reserved.
//

import Foundation
import UIKit

class BeardListViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var beards: [Beard] = []
    private let cellId = "BeardCell"
    
    // MARK: Functions
    
    /// Standard viewDidLoad
    override func viewDidLoad() {
        
        title = "Beards for everyone"
        
        // Mock data
        beards.append(Beard(type: .Mustache, length: 5.2, imageName: "mustache"))
        beards.append(Beard(type: .Full, length: 12.8, imageName: "beard"))
        beards.append(Beard(type: .Chin, length: 1.8, imageName: nil))
    }
    
    /// Add a new beard to beards and the table
    private func insert() {
        
        beards.append((Beard(type: .Chin, length: 1.8, imageName: nil)))
        let insertionIndexPath = NSIndexPath(forRow: beards.count-1, inSection: 0)
        tableView.insertRowsAtIndexPaths([insertionIndexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Outlets
    
    @IBAction func addNewBeard(sender: UIBarButtonItem) {
        insert()
    }
}

// MARK: - Delegate
extension BeardListViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let beard = beards[indexPath.row]
        let text = String(format: "%@ with length %1.2f", beard.type.rawValue, beard.length)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        cell.imageView?.image = UIImage(named: beard.imageName ?? "")
        cell.textLabel?.text = text
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            beards.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beards.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("row selected \(indexPath.row)")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
}