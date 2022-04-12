//
//  NewEntryViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 23/1/1401 AP.
//

import UIKit

class NewEntryViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var daysTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func confirmButtonAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()

    }

    func setupUI() {
        confirmButton.layer.cornerRadius = 15
        confirmButton.clipsToBounds = true
        confirmButton.layer.borderWidth = 2.0
        confirmButton.layer.cornerRadius = 15
        confirmButton.layer.borderColor = appGlobalTintColor?.cgColor ?? UIColor.systemBlue.cgColor
        titleTextField.borderStyle = .bezel
        titleTextField.layer.masksToBounds = true
        titleTextField.layer.borderColor = appGlobalTintColor?.cgColor ?? UIColor.systemBlue.cgColor
        titleTextField.layer.borderWidth = 2.0
        titleTextField.layer.cornerRadius = 15
        titleTextField.clipsToBounds = true
        placeTextField.borderStyle = .roundedRect
        placeTextField.layer.masksToBounds = true
        placeTextField.layer.borderColor = appGlobalTintColor?.cgColor ?? UIColor.systemBlue.cgColor
        placeTextField.layer.borderWidth = 2.0
        placeTextField.layer.cornerRadius = 15
        placeTextField.clipsToBounds = true
        budgetTextField.borderStyle = .roundedRect
        budgetTextField.layer.masksToBounds = true
        budgetTextField.layer.borderColor = appGlobalTintColor?.cgColor ?? UIColor.systemBlue.cgColor
        budgetTextField.layer.borderWidth = 2.0
        budgetTextField.layer.cornerRadius = 15
        budgetTextField.clipsToBounds = true
        daysTextField.borderStyle = .roundedRect
        daysTextField.layer.masksToBounds = true
        daysTextField.layer.borderColor = appGlobalTintColor?.cgColor ?? UIColor.systemBlue.cgColor
        daysTextField.layer.borderWidth = 2.0
        daysTextField.layer.cornerRadius = 15
        daysTextField.clipsToBounds = true
    }
}
