//
//  NoteViewController.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.keyboardDismissMode = .onDrag
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
        for i in 0..<allTrips.count {
            if allTrips[i].title == currentTrip?.title && allTrips[i].place == currentTrip?.place {
                allTrips[i] = currentTrip!
            }
        }
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
    
}
