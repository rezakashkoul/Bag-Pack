//
//  NewEntryViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 23/1/1401 AP.
//

import UIKit

protocol NewEntryViewControllerDelegate: AnyObject {
    func goForFillData()
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
                delegate?.goForFillData()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.slideUpViews(delay: 0.2)
    }
    
    func setupUI() {
        title = "New Trip"
        descriptionLabel.textColor = appGlobalTintColor ?? UIColor.systemBlue
        
        confirmButton.layer.masksToBounds = true
        confirmButton.layer.cornerRadius = 12
        confirmButton.clipsToBounds = false
        confirmButton.layer.shadowOpacity=0.4
        confirmButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        confirmButton.layer.shadowColor = UIColor.darkGray.cgColor
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
        titleTextField.layer.shadowOffset = CGSize(width: 2, height: 2)
        titleTextField.layer.shadowColor = UIColor.darkGray.cgColor
        titleTextField.setPlaceHolderColor(color: .gray)
        
        placeTextField.borderStyle = .roundedRect
        placeTextField.layer.masksToBounds = true
        placeTextField.layer.cornerRadius = titleTextField.frame.size.height/2
        placeTextField.clipsToBounds = false
        placeTextField.layer.shadowOpacity=0.4
        placeTextField.layer.shadowOffset = CGSize(width: 2, height: 2)
        placeTextField.layer.shadowColor = UIColor.darkGray.cgColor
        placeTextField.setPlaceHolderColor(color: .gray)
        
        budgetTextField.borderStyle = .roundedRect
        budgetTextField.layer.masksToBounds = true
        budgetTextField.layer.cornerRadius = titleTextField.frame.size.height/2
        budgetTextField.clipsToBounds = false
        budgetTextField.layer.shadowOpacity=0.4
        budgetTextField.layer.shadowOffset = CGSize(width: 2, height: 2)
        budgetTextField.layer.shadowColor = UIColor.darkGray.cgColor
        budgetTextField.setPlaceHolderColor(color: .gray)
        
        daysTextField.borderStyle = .roundedRect
        daysTextField.layer.masksToBounds = true
        daysTextField.layer.cornerRadius = titleTextField.frame.size.height/2
        daysTextField.clipsToBounds = false
        daysTextField.layer.shadowOpacity=0.4
        daysTextField.layer.shadowOffset = CGSize(width: 2, height: 2)
        daysTextField.layer.shadowColor = UIColor.darkGray.cgColor
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        switch textField {
        case titleTextField:
            return true
        case placeTextField:
            return true
        case daysTextField:
            return string == numberFiltered
        case budgetTextField:
            return string == numberFiltered
        default:
            break
        }
        return true
    }
    
}
