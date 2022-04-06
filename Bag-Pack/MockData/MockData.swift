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
        Travel(title: "Tehran Trip", place: "Iran", date: "22.01.11", climate: "", currency: "0.0001 $", travelLength: 6),
        Travel(title: "London Trip", place: "Iran", date: "21.11.21", climate: "", currency: "0.1.3 $", travelLength: 30)
    ]
    
    
}
