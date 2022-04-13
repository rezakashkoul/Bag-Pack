//
//  TravelModel.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation

struct Travel: Codable {
    
    let title, place, date, climate, budget, days : String
}

struct CostDetails: Codable {
    var title, price: String
}
