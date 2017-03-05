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
  
  var photo: UIImage? {
    didSet {
      
      beardImageView?.image = photo
      
      if photo != nil {
        
        cameraButton?.isHidden = true
        openLibraryButton?.isHidden = true
        
        deletePhotoButton?.isHidden = false
        view.bringSubview(toFront: deletePhotoButton)
        
      } else {
        
        cameraButton?.isHidden = false
        view.bringSubview(toFront: cameraButton)
        
        openLibraryButton?.isHidden = false
        view.bringSubview(toFront: openLibraryButton)
        
        deletePhotoButton?.isHidden = true
      }
    }
  }
  
  fileprivate let typePicker = UIPickerView()
  
  private var appDelegate: AppDelegate {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      return appDelegate
    } else {
      fatalError("Couln't access app delegate")
    }
  }
  
  private var managedContext: NSManagedObjectContext {
    return appDelegate.persistentContainer.viewContext
  }
  
  // MARK: - Actions
  
  @IBAction private func takePhoto() {

    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
      imagePicker.allowsEditing = true
      self.present(imagePicker, animated: true, completion: nil)
    }
  }
  
  @IBAction func openPhotoLibraryButton(sender: AnyObject) {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
      imagePicker.allowsEditing = true
      self.present(imagePicker, animated: true, completion: nil)
    }
  }
  
  @IBAction func deletePhoto() {
    photo = nil
  }
  
  // MARK: - Outlets
  
  @IBOutlet private weak var beardImageView: UIImageView!
  
  @IBOutlet private weak var cameraButton: UIButton!
  
  @IBOutlet private weak var openLibraryButton: UIButton!{
    didSet {
      openLibraryButton.isHidden = true
      openLibraryButton.setTitle(NSLocalizedString("OPEN_PHOTO_LIBRARY_BUTTON", comment: ""), for: .normal)
    }
  }
  
  @IBOutlet private weak var deletePhotoButton: UIButton! {
    didSet {
      deletePhotoButton.isHidden = true
      deletePhotoButton.setTitle(NSLocalizedString("DELETE_PHOTO_BUTTON", comment: ""), for: .normal)
    }
  }
  
  @IBOutlet private weak var typeLabel: UILabel! {
    didSet {
      typeLabel.text = NSLocalizedString("BEARD_TYPE_LABEL", comment: "")
      typeLabel.font = UIFont(name: "", size: 32.0)
    }
  }
  
  @IBOutlet fileprivate weak var typeTextfield: UITextField! {
    didSet {
      typeTextfield.placeholder = BeardType.None.rawValue
      typeTextfield.font = UIFont(name: "", size: 32.0)
      
      typeTextfield.inputView = typePicker
    }
  }
  
  @IBOutlet private weak var lenghtLabel: UILabel! {
    didSet {
      lenghtLabel.text = NSLocalizedString("BEARD_LENGTH_LABEL", comment: "")
      lenghtLabel.font = UIFont(name: "", size: 32.0)
    }
  }
  
  
  @IBOutlet private weak var lengthTextfield: UITextField! {
    didSet {
      lengthTextfield.placeholder = NSLocalizedString("BEARD_LENGTH_INPUT", comment: "")
      lengthTextfield.font = UIFont(name: "", size: 32.0)
    }
  }
  
  @IBOutlet private weak var dateTextfield: UITextField! {
    didSet {
      dateTextfield.text = "Todo: date"
    }
  }
  
  // MARK: - Override functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("BEARD_SAVE_BUTTON", comment: ""), style: .plain, target: self, action: #selector(saveBeard))
    
    setupTypePicker()
    setupLengthPicker()
  }
  
  // MARK: - Functions
  
  fileprivate func setupLengthPicker() {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    toolbar.isUserInteractionEnabled = true
    
    // close picker button
    let closePickerBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(BeardInputViewController.closeLengthPicker))
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil);
    
    toolbar.items = [flexibleSpace, closePickerBarButton]
    
    lengthTextfield.inputAccessoryView = toolbar
  }

  fileprivate func setupTypePicker() {
    
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    toolbar.isUserInteractionEnabled = true
    
    let closePickerBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(BeardInputViewController.closeTypePicker))
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil);
    
    toolbar.items = [flexibleSpace, closePickerBarButton]
    
    typePicker.delegate = self
    self.typeTextfield.inputView = typePicker
    typeTextfield.inputAccessoryView = toolbar
    
  }
  
  func closeLengthPicker() {
    lengthTextfield.endEditing(true)
  }
  
  func closeTypePicker() {
    typeTextfield.endEditing(true)
  }
  
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

extension BeardInputViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    if let photo = info["UIImagePickerControllerEditedImage"] as? UIImage {
      self.photo = photo
    } else {
      print("Something went wrong")
    }
    
    self.dismiss(animated: true, completion: nil)
  }
}
