//
//  MockData.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation

class MockData {
    
    static let shared = MockData()
    
    let travelMockData : [Travel] = [
        Travel(title: "Tehran Trip", place: "Iran", date: "22.01.11", climate: "", budget: "0.0001 $", days: "6"),
        Travel(title: "London Trip", place: "Iran", date: "21.11.21", climate: "", budget: "0.1.3 $", days: "30")
    ]
    
    
}
