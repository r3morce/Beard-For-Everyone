//
//  BeardInputViewController.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 29.08.16.
//  Copyright © 2016 mathias. All rights reserved.
//

import UIKit

class BeardInputViewController: UIViewController {
    
    // MARK: - Properties
    
    private let picker = UIPickerView()
    
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
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("BEARD_SAVE_BUTTON", comment: ""), style: .Plain, target: self, action: #selector(saveBeard))
        
        // setup picker
        setupTypePicker()
        setupLengthPicker()
    }
    
    // MARK: - Functions
    
    /// setup length picker
    
    private func setupLengthPicker() {
        // close picker button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.userInteractionEnabled = true
        
        // close picker button
        let closePickerBarButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(BeardInputViewController.closeLengthPicker))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil);
        
        toolbar.items = [flexibleSpace, closePickerBarButton]
 
        lengthTextfield.inputAccessoryView = toolbar
    }
    
    /// setup type picker
    private func setupTypePicker() {
        
        // close picker button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.userInteractionEnabled = true
        
        // close picker button
        let closePickerBarButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(BeardInputViewController.closeTypePicker))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil);
        
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
        
        guard let inputLength = lengthTextfield.text, let length = Double(inputLength) else {
            return
        }
        
        guard let inputType = typeTextfield.text, let type = BeardType(rawValue: inputType) else {
            return
        }
        
        let beard = Beard(type: type, length: length, imageName: nil)
        
        Global.beards.append(beard)
        
        navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: - Extension: UIPickerViewDelegate, UIPickerViewDataSource

extension BeardInputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BeardType.all.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BeardType.all[row].rawValue
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextfield.text = BeardType.all[row].rawValue
    }
    
    
}