//
//  AlertManager.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation
import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    
    func showAlert(parent: UIViewController, title: String, body: String, buttonTitles: [String], style: UIAlertController.Style = .actionSheet, showCancelButton: Bool = true, completion: @escaping (Int?)->()) {
        let alert = UIAlertController(title: title, message: "\n" + body, preferredStyle: style)
        for i in 0..<buttonTitles.count {
            let action = UIAlertAction(title: buttonTitles[i], style: .default) { _ in
                completion(i)
            }
            alert.addAction(action)
        }
        if showCancelButton {
            let action = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                completion(nil)
            }
            alert.addAction(action)
        }
        parent.present(alert, animated: true)
    }
    
    func showAlertWithTextField(parent: UIViewController, title: String, placeHolder: String, buttonTitle: String, style: UIAlertController.Style = .alert, showCancelButton: Bool = true, completion: @escaping (String?)->()) {
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: style)
        var textField = UITextField()
        alert.addTextField { text in
            textField = text
            textField.placeholder = placeHolder
        }
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion(textField.text)
        }
        alert.addAction(action)
        if showCancelButton {
            let action = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                completion(nil)
            }
            alert.addAction(action)
        }
        parent.present(alert, animated: true)
    }
    
}
