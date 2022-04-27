//
//  NoteViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit
import WhatsNewKit

class NoteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.keyboardDismissMode = .onDrag
        setupKeyboard()
        showWelcomeToNote()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        loadData()
        if currentTrip!.travelSubData.note == "" {
            textView.placeholder = "Type here..."
        } else {
            textView.text = currentTrip!.travelSubData.note
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        currentTrip?.travelSubData.note = textView.text
        saveData()
    }
    
    func setupUI() {
        navigationItem.title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backButton))
    }
    
    @objc private func backButton() {
        tabBarController?.navigationController?.popViewController(animated: true)
    }
    
    func showWelcomeToNote() {
        let detailVc = WhatsNewViewController(
            whatsNew:
                WhatsNew(title: "Add a New Note!", items: [
                    WhatsNew.Item(title: "Write your ideas, comments or any notes for this trip. ", subtitle: "This will help you never miss anything or happenings in the trip.This really can effect on your future trips.", image: UIImage(named: "noteItem")),
                ]))
        present(detailVc, animated: true)
    }
    
}

//MARK: - Handle Keyboard Events
extension NoteViewController {
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight : Int = Int(keyboardSize.height)
            bottomConstraint.constant = CGFloat(keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(){
        bottomConstraint.constant = 0
    }
}
