//
//  GlobalVariables.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation
import UIKit

enum ApplicationError: Error {
    case general
    case timeout
    case noData
    case decode
    case badURL
}

enum CurrencyUnits: Int {
    case dollar = 0
    case euro = 1
    case rial = 2
}

var currentTrip: Travel?
var allTrips: [Travel] = []
var useMockData = true
var isDarkMode: Bool {
    get {
        UserDefaults.standard.bool(forKey: "theme")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "theme")
    }
}
var appCurrencyUnit: CurrencyUnits? {
    get {
        CurrencyUnits(rawValue: UserDefaults.standard.integer(forKey: "unit")) ?? .dollar
    }
    set{
        UserDefaults.standard.set(newValue?.rawValue, forKey: "unit")
    }
}
var appGlobalTintColor: UIColor? {
    get {
        UserDefaults.standard.colorForKey(key: "color")
    }
    set {
        UserDefaults.standard.setColor(color: newValue, forKey: "color")
    }
}

func saveData() {
    if currentTrip != nil && allTrips.count > 0 {
        for i in 0..<allTrips.count {
            if allTrips[i].title == currentTrip?.title && allTrips[i].place == currentTrip?.place {
                allTrips[i] = currentTrip!
            }
        }
    }
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(allTrips)
        UserDefaults.standard.set(data, forKey: "travel")
    } catch {
        print("Unable to Encode saveData (\(error))")
    }
}

func loadData() {
    if let data = UserDefaults.standard.data(forKey: "travel") {
        do {
            let decoder = JSONDecoder()
            allTrips = try decoder.decode([Travel].self, from: data)
        } catch {
            print("Unable to Decode loadData (\(error))")
        }
    }
}

