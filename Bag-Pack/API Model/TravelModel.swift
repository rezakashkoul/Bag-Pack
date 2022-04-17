//
//  TravelModel.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation

//struct Travel: Codable {
//
//    let title, place, date, climate, budget, days : String
//}
//
//struct CostDetails: Codable {
//    var title, price: String
//}

import Foundation

struct Travel: Codable {
    
    let title, place, budget, days: String
//    let date, climate: String
    var travelSubData: TravelSubData
    
    
    init(title: String, place: String, budget: String, days: String, travelSubData: TravelSubData) {
        self.title = title
        self.place = place
        self.budget = budget
        self.days = days
        self.travelSubData = travelSubData
    }
    
}

struct TravelSubData: Codable {
    
    var essential: [String]
    var note: String
    var cost: [CostDetails]
    
    init(essential: [String], note: String, cost: [CostDetails]) {
        self.essential = essential
        self.note = note
        self.cost = cost
    }
}

struct CostDetails: Codable {

    var title, price: String
    init(title: String, price: String) {
        self.title = title
        self.price = price
    }
}
