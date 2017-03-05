//
//  BeardInputViewController.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 29.08.16.
//  Copyright © 2016 mathias. All rights reserved.
//

import UIKit
import CoreData

class BeardInputViewController: UIViewController {
  
  // MARK: - Properties
  
  fileprivate let picker = UIPickerView()
  
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
  
  // MARK: - Actions
  
  
  
  // MARK: - Outlets
  
  @IBOutlet weak var typeLabel: UILabel! {
    didSet {
      typeLabel.text = NSLocalizedString("BEARD_TYPE_LABEL", comment: "")
      typeLabel.font = UIFont(name: "", size: 32.0)
    }
  }
  
  @IBOutlet weak var typeTextfield: UITextField! {
    didSet {
      typeTextfield.placeholder = BeardType.None.rawValue
      typeTextfield.font = UIFont(name: "", size: 32.0)
      
      typeTextfield.inputView = picker
    }
  }
  
  @IBOutlet weak var lenghtLabel: UILabel! {
    didSet {
      lenghtLabel.text = NSLocalizedString("BEARD_LENGTH_LABEL", comment: "")
      lenghtLabel.font = UIFont(name: "", size: 32.0)
    }
  }
  
  
  @IBOutlet weak var lengthTextfield: UITextField! {
    didSet {
      lengthTextfield.placeholder = NSLocalizedString("BEARD_LENGTH_INPUT", comment: "")
      lengthTextfield.font = UIFont(name: "", size: 32.0)
    }
  }
  
  @IBOutlet weak var dateTextfield: UITextField! {
    didSet {
      dateTextfield.text = "Todo: date"
    }
  }
  
  // MARK: - Override functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // save button
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("BEARD_SAVE_BUTTON", comment: ""), style: .plain, target: self, action: #selector(saveBeard))
    
    // setup picker
    setupTypePicker()
    setupLengthPicker()
  }
  
  // MARK: - Functions
  
  /// setup length picker
  
  fileprivate func setupLengthPicker() {
    // close picker button
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    toolbar.isUserInteractionEnabled = true
    
    // close picker button
    let closePickerBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(BeardInputViewController.closeLengthPicker))
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil);
    
    toolbar.items = [flexibleSpace, closePickerBarButton]
    
    lengthTextfield.inputAccessoryView = toolbar
  }
  
  /// setup type picker
  fileprivate func setupTypePicker() {
    
    // close picker button
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    toolbar.isUserInteractionEnabled = true
    
    // close picker button
    let closePickerBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(BeardInputViewController.closeTypePicker))
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil);
    
    toolbar.items = [flexibleSpace, closePickerBarButton]
    
    picker.delegate = self
    self.typeTextfield.inputView = picker
    typeTextfield.inputAccessoryView = toolbar
    
  }
  
  /// close length picker
  func closeLengthPicker() {
    lengthTextfield.endEditing(true)
  }
  
  /// close type picker
  func closeTypePicker() {
    typeTextfield.endEditing(true)
  }
  
  /// save beard
  func saveBeard() {
    
    guard let inputLength = lengthTextfield.text, let length = Float(inputLength) else {
      return
    }
    
    guard let inputType = typeTextfield.text, let type = BeardType(rawValue: inputType) else {
      return
    }
    
    let beard = NSEntityDescription.insertNewObject(forEntityName: "Beard", into: managedContext) as! Beard
    beard.type = type.rawValue
    beard.length = length
    beard.date = Date() as NSDate
    
    appDelegate.saveContext()
    
    let _ = navigationController?.popViewController(animated: true)
  }
}

// MARK: - Extension: UIPickerViewDelegate, UIPickerViewDataSource

extension BeardInputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return BeardType.all.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return BeardType.all[row].rawValue
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    typeTextfield.text = BeardType.all[row].rawValue
  }
  
  
}
