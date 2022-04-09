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
    
    func showCompleteFormOfAlert(parent: UIViewController, title: String, message: String, placeHolders: [String], buttonTitles: [String], style: UIAlertController.Style = .actionSheet, showCancelButton: Bool = true, completion: @escaping (Int?)->(), textCompletion: @escaping ([String])->()) {
        
        let alert = UIAlertController(title: title, message: "\n" + message, preferredStyle: style)
        var textField = UITextField()
        var texts: [String] = []
        
        for i in 0..<placeHolders.count {
            alert.addTextField { closureTextField in
                textField = closureTextField
                textField.placeholder = placeHolders[i]
                if i == 1 {
                    textField.keyboardType = .numberPad
                } else {
                    textField.keyboardType = .default
                }
            }
        }
        
        for i in 0..<buttonTitles.count {
            let action = UIAlertAction(title: buttonTitles[i], style: .default) { _ in
                
                for j in 0..<placeHolders.count {
                    let textFields = alert.textFields
                    guard textFields?[j].text != "" && textFields?[j].text != nil && textFields?[j].text != " " else {return}
                    texts.append(textFields![j].text!)
                }
                textCompletion(texts)
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
    
}
