//
//  GlobalVariables.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation
import UIKit

var useMockData = true
var isDarkMode: Bool {
    get {
        UserDefaults.standard.bool(forKey: "theme")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "theme")
    }
}

enum ApplicationError: Error {
    case general
    case timeout
    case noData
    case decode
    case badURL
}

var appGlobalTintColor: UIColor? {
    get {
        UserDefaults.standard.colorForKey(key: "color")
    }
    set {
        UserDefaults.standard.setColor(color: newValue, forKey: "color")
    }
}

