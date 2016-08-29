//
//  BeardInputViewController.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 29.08.16.
//  Copyright © 2016 mathias. All rights reserved.
//

import UIKit

class BeardInputViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var typeLabel: UILabel! {
        didSet {
            typeLabel.text = NSLocalizedString("BEARD_TYPE_LABEL", comment: "")
            typeLabel.font = UIFont(name: "", size: 32.0)
        }
    }
    
    @IBOutlet weak var typeTextfield: UITextField! {
        didSet{
            typeTextfield.placeholder = NSLocalizedString("BEARD_TYPE_INPUT", comment: "")
            typeTextfield.font = UIFont(name: "", size: 32.0)
        }
    }
    
    @IBOutlet weak var lenghtLabel: UILabel! {
        didSet {
            lenghtLabel.text = NSLocalizedString("BEARD_LENGTH_LABEL", comment: "")
            lenghtLabel.font = UIFont(name: "", size: 32.0)
        }
    }

    
    @IBOutlet weak var lengthTextfield: UITextField! {
        didSet{
            lengthTextfield.placeholder = NSLocalizedString("BEARD_LENGTH_INPUT", comment: "")
            lengthTextfield.font = UIFont(name: "", size: 32.0)
        }
    }

    // MARK: - Functions
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("BEARD_SAVE_BUTTON", comment: ""), style: .Plain, target: self, action: #selector(save))
    }
    
    func save() {
        
//        let newBeard = Beard(type: <#T##Beard.Type#>, length: <#T##Double#>, imageName: <#T##String?#>)
        
        
        
        print(typeTextfield.text)
        print(lengthTextfield.text)
        
    }
}