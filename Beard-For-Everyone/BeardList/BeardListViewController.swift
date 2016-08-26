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
    

    
    // - MARK: Properties
    private var beards: [Beard] = []
    private let cellId = "BeardCell"
    
    // - MARK: Functions
    override func viewDidLoad() {
        
        title = "Beards for everyone"
        
        // Mock data
        beards.append(Beard(type: .Mustache, length: 5.2))
        beards.append(Beard(type: .Full, length: 12.8))
        beards.append(Beard(type: .Chin, length: 1.8))
    }
    
}

// - MARK: Delegate
extension BeardListViewController {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let beard = beards[indexPath.row]
        let text = String(format: "%@ with length %1.2f", beard.type.rawValue, beard.length)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        cell.textLabel?.text = text
        
        return cell
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
}