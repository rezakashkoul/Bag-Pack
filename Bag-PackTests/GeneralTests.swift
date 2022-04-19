//
//  GeneralTests.swift
//  Bag-PackTests
//
//  Created by Reza Kashkoul on 30/1/1401 AP.
//

import XCTest
import Foundation
@testable import Bag_Pack

class GeneralTests: XCTestCase {
    
    func test_loadData() {
        do {
            let mockData = MockData.shared.travelMockData
            let encoder = JSONEncoder()
            let data = try encoder.encode(mockData)
            UserDefaults.standard.set(data, forKey: "travel")
        } catch {
            print("Unable to Encode saveData (\(error))")
        }
        let travelData = UserDefaults.standard.data(forKey: "travel")
        XCTAssertNotNil(travelData)
    }
    
}
