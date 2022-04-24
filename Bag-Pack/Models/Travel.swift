//
//  TravelModel.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation

struct Travel: Codable {
    
    //    let date, climate: String
    let title, place, budget, days, date: String
    var travelSubData: TravelSubData
    
    init(title: String, place: String, budget: String, days: String, date: String, travelSubData: TravelSubData) {
        self.title = title
        self.place = place
        self.budget = budget
        self.days = days
        self.date = date
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
