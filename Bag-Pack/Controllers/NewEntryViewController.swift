//
//  NewEntryViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 23/1/1401 AP.
//

import UIKit

protocol NewEntryViewControllerDelegate: AnyObject {
    func goForFillData(tripData: Travel)
}
class NewEntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var daysTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        
        if titleTextField.text != "" &&
            placeTextField.text != "" &&
            budgetTextField.text != "" &&
            daysTextField.text != "" {
            currentTrip = Travel(title: titleTextField.text ?? "Trip", place: placeTextField.text ?? "Place", budget: budgetTextField.text ?? "Not specified", days: daysTextField.text ?? "Not specified", travelSubData: TravelSubData(essential: [], note: "", cost: []))
            
            dismiss(animated: true) { [self] in
                if let currentTrip = currentTrip {
                    delegate?.goForFillData(tripData: currentTrip)
                }
            }
        } else {
            AlertManager.shared.showAlert(parent: self, title: "Error!", body: "Please fill every fields", buttonTitles: ["OK"], style: .alert, showCancelButton: false) { _ in
            }
        }
    }
    
    weak var delegate: NewEntryViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        placeTextField.delegate = self
        budgetTextField.delegate = self
        daysTextField.delegate = self
        setupUI()
    }
    
    func setupUI() {
        title = "New Trip"
        descriptionLabel.textColor = appGlobalTintColor ?? UIColor.systemBlue
        confirmButton.layer.cornerRadius = 15
        confirmButton.clipsToBounds = true
        confirmButton.layer.borderWidth = 2.0
        confirmButton.layer.cornerRadius = 15
        confirmButton.backgroundColor = appGlobalTintColor
        if #available(iOS 13.0, *) {
            confirmButton.setTitleColor(.systemBackground, for: .normal)
        } else {
            // Fallback on earlier versions
        }
        
        titleTextField.borderStyle = .roundedRect
        titleTextField.layer.masksToBounds = true
        titleTextField.layer.cornerRadius = titleTextField.frame.size.height/2
        titleTextField.clipsToBounds = false
        titleTextField.layer.shadowOpacity=0.4
        titleTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
        titleTextField.layer.shadowColor = appGlobalTintColor?.cgColor
        titleTextField.setPlaceHolderColor(color: .gray)
        
        placeTextField.borderStyle = .roundedRect
        placeTextField.layer.masksToBounds = true
        placeTextField.layer.cornerRadius = titleTextField.frame.size.height/2
        placeTextField.clipsToBounds = false
        placeTextField.layer.shadowOpacity=0.4
        placeTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
        placeTextField.layer.shadowColor = appGlobalTintColor?.cgColor
        placeTextField.setPlaceHolderColor(color: .gray)
        
        budgetTextField.borderStyle = .roundedRect
        budgetTextField.layer.masksToBounds = true
        budgetTextField.layer.cornerRadius = titleTextField.frame.size.height/2
        budgetTextField.clipsToBounds = false
        budgetTextField.layer.shadowOpacity=0.4
        budgetTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
        budgetTextField.layer.shadowColor = appGlobalTintColor?.cgColor
        budgetTextField.setPlaceHolderColor(color: .gray)
        
        daysTextField.borderStyle = .roundedRect
        daysTextField.layer.masksToBounds = true
        daysTextField.layer.cornerRadius = titleTextField.frame.size.height/2
        daysTextField.clipsToBounds = false
        daysTextField.layer.shadowOpacity=0.4
        daysTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
        daysTextField.layer.shadowColor = appGlobalTintColor?.cgColor
        daysTextField.setPlaceHolderColor(color: .gray)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField && titleTextField.text != "" {
            textField.resignFirstResponder()
            placeTextField.becomeFirstResponder()
        } else if textField == placeTextField && placeTextField.text != "" {
            textField.resignFirstResponder()
            budgetTextField.becomeFirstResponder()
        } else if textField == budgetTextField && budgetTextField.text != "" {
            textField.resignFirstResponder()
            daysTextField.becomeFirstResponder()
        }
        return true
    }
    
}
