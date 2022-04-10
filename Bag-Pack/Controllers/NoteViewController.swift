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
//        textView.keyboardDismissMode = .onDrag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        textView.text = loadNote()
        if textView.text == "" {
            textView.placeholder = "Type here..."
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveNote(textView.text)
    }
    
    func setupUI() {
        navigationItem.title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dashboard", style: .done, target: self, action: #selector(backButton))
    }
    @objc private func backButton() {
        tabBarController?.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - Save/Load list to userDefault
extension NoteViewController {
    
    func saveNote(_ text: String){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(text)
            UserDefaults.standard.set(data, forKey: "note")
        } catch {
            print("Unable to Encode note (\(error))")
        }
    }
    
    func loadNote()-> String {
        if let data = UserDefaults.standard.data(forKey: "note") {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(String.self, from: data)
            } catch {
                print("Unable to Decode note (\(error))")
                return ""
            }
        }
        return ""
    }
}

