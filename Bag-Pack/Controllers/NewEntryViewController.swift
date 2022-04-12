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

        confirmButton.layer.cornerRadius = 12
        confirmButton.clipsToBounds = true
        title = "Bag-Pack"
    }


}
