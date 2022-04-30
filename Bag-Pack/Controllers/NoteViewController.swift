//
//  NoteViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit
import AppleWelcomeScreen

class NoteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.keyboardDismissMode = .onDrag
        setupKeyboard()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "help"), style: .plain, target: self, action: #selector(showGuideAction))
    }
    
    @objc private func showGuideAction() {
        showGuide()
    }
    
    @objc private func backButton() {
        tabBarController?.navigationController?.popViewController(animated: true)
    }
    
    func showGuide() {
        var configuration = WelcomeScreenConfiguration(
            appName: "Note",
            appDescription: "Add a New Note!",
            features: [
                WelcomeScreenFeature(
                    image: UIImage(named: "noteItem")!,
                    title: "Write your ideas, comments or any notes for this trip.",
                    description: "This will help you never miss anything or happenings in the trip. This really can effect on your future trips."
                )
            ]
        )
        configuration.welcomeString = ""
        configuration.tintColor = appGlobalTintColor
        present(WelcomeScreenViewController(configuration: configuration), animated: true)
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
