//
//  BeardListViewController.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 26.08.16.
//  Copyright © 2016 mathias. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BeardListViewController: UITableViewController {
  
  // MARK: - Properties
  
  fileprivate let cellId = "BeardCell"
  fileprivate var beards: [Beard] {
    do {
      let request = NSFetchRequest<Beard>(entityName: EntityName.beard)
      return try self.managedContext.fetch(request)
    } catch {
      fatalError("Couldn't access beards")
    }
  }
  
  var appDelegate: AppDelegate {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      return appDelegate
    } else {
      fatalError("Couln't access app delegate")
    }
  }
  
  var managedContext: NSManagedObjectContext {
    return appDelegate.persistentContainer.viewContext
  }
  
  // MARK: Functions
  
  /// Standard view will appear
  override func viewDidLoad() {
    
    title = NSLocalizedString("APP_NAME", comment: "")
  }
  
  // Standart view will appear
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
  
  // MARK: - Outlets
  
  @IBAction func addNewBeard(_ sender: UIBarButtonItem) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "BeardInputViewController") as! BeardInputViewController
    viewController.beard = nil
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - Delegate
extension BeardListViewController {
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let beard = beards[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

    if let type = beard.type {
      cell.textLabel?.text = String(format: NSLocalizedString("BEARD_LIST_TEXT", comment: "two string parameter"), type, beard.length.niceLength)
    } else {
      cell.textLabel?.text = BeardType.None.rawValue
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == UITableViewCellEditingStyle.delete) {
      
      tableView.beginUpdates()
      
      managedContext.delete(beards[indexPath.row])
      appDelegate.saveContext()
      
      tableView.deleteRows(at: [indexPath], with: .automatic)
      
      tableView.endUpdates()
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return beards.count
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("row selected \(indexPath.row)")
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "BeardInputViewController") as! BeardInputViewController
    viewController.beard = beards[indexPath.row]
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0
  }
}
