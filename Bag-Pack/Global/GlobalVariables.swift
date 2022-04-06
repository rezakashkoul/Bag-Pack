//
//  GlobalVariables.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 16/1/1401 AP.
//

import Foundation

var useMockData = true

enum ApplicationError: Error {
    case general
    case timeout
    case noData
    case decode
    case badURL
}
