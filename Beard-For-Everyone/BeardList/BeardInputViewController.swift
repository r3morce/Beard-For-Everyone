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
    
    // MARK: - Outlets
    
    @IBOutlet weak var typeLabel: UILabel! {
        didSet {
            typeLabel.text = NSLocalizedString("BEARD_TYPE_LABEL", comment: "")
            typeLabel.font = UIFont(name: "", size: 32.0)
        }
    }
    
    @IBOutlet weak var typeTextfield: UITextField! {
        didSet {
            typeTextfield.placeholder = NSLocalizedString("BEARD_TYPE_INPUT", comment: "")
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
        
        picker.delegate = self
        self.typeTextfield.inputView = picker
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("BEARD_SAVE_BUTTON", comment: ""), style: .Plain, target: self, action: #selector(saveBeard))
        
        // picker
        let pickerToolbar = UIToolbar(frame: CGRectMake(0,0,320,44))
        let closePickerButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(BeardInputViewController.closePicker))
        // let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil);
        
        pickerToolbar.items = [/*flexibleSpace, */ closePickerButton]
        
        picker.addSubview(pickerToolbar)
    }
    
    // MARK: - Functions
    
    func closePicker() {
        print("done")
        // picker.hidden = true
        // picker.endEditing(true)
    }
    
    func saveBeard() {
        
        guard let inputLength = lengthTextfield.text, let length = Double(inputLength) else {
            return
        }
        
        guard let inputType = typeTextfield.text, let type = BeardType(rawValue: inputType) else {
            return
        }
        
        let beard = Beard(type: type, length: length, imageName: nil)
        
        Global.beards.append(beard)
    }
}

// MARK: - Extension: UIPickerViewDelegate, UIPickerViewDataSource

extension BeardInputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Global.beards.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Global.beards[row].type.rawValue
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextfield.text = Global.beards[row].type.rawValue
    }
    
    
}