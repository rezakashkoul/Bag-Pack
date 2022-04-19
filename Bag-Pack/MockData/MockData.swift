//
//  MockData.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation

class MockData {
    
    static let shared = MockData()
    
    class MockData {
        
        static let shared = MockData()
        
        let travelMockData : [Travel] = [
            
            Travel(title: "Tehran Trip", place: "Iran", budget: "0.001 $", days: "6", date: "2022-01-02", travelSubData: TravelSubData(essential: ["Charger", "Wallet"], note: "hmmmm", cost: [CostDetails(title: "Shampoo", price: "1200"), CostDetails(title: "Gas", price: "120")])),
            
            Travel(title: "London Trip", place: "Iran", budget: "0.1 $", days: "30", date: "2022-03-06", travelSubData: TravelSubData(essential: ["Books", "Lighter"], note: "Try to enjoy", cost: [CostDetails(title: "Shampoo", price: "1200"), CostDetails(title: "Hat", price: "99")]))
        ]
        
    }

    
    
}
